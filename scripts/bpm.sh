#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   bpm-tag.sh 128
# or
#   bpm-tag.sh        # will prompt for BPM
# Dependencies:
#   sudo pacman -S fd fzf ffmpeg python-mutagen viu flac vorbis-tools atomicparsley

bpm="${1:-}"
if [ -z "$bpm" ]; then
    read -r -p "BPM (int or decimal): " bpm
    [ -z "$bpm" ] && {
        echo "No BPM entered, aborting."
        exit 1
    }
fi

# preview helper called by fzf:
# tries to extract an attached image with ffmpeg and display it with viu.
# if no image found, falls back to mutagen-inspect (prints tags).
_preview_cmd() {
    # $1 is the file passed by fzf
    f="$1"
    tmp="$(mktemp --tmpdir fzf-cover-XXXXXX).img"

    # Try extracting attached picture(s) with ffmpeg.
    # -map 0:v tries to map the first video/attachment stream (cover art).
    # This works for mp3, m4a/mp4, and many other container types.
    if ffmpeg -v error -y -i "$f" -an -map 0:v:0 -c copy "$tmp" 2>/dev/null ||
        ffmpeg -v error -y -i "$f" -an -map 0:v -c copy "$tmp" 2>/dev/null; then
        # use viu if available
        if command -v viu >/dev/null 2>&1; then
            viu --quiet "$tmp" || true
        else
            # fallback: print path and basic info if no image renderer
            echo "[cover extracted to $tmp]"
            file "$tmp"
        fi
        rm -f "$tmp"
        exit 0
    fi

    # If ffmpeg didn't find an attached picture, try format-specific extractors:
    # - for FLAC, use metaflac
    if command -v metaflac >/dev/null 2>&1 && [[ "${f,,}" =~ \.flac$ ]]; then
        tmp2="$(mktemp --tmpdir fzf-cover-XXXXXX).img"
        if metaflac --export-picture-to="$tmp2" "$f" >/dev/null 2>&1; then
            command -v viu >/dev/null 2>&1 && viu --quiet "$tmp2" || {
                echo "[cover extracted to $tmp2]"
                file "$tmp2"
            }
            rm -f "$tmp2"
            exit 0
        fi
        rm -f "$tmp2"
    fi

    # If still no image: show tags / metadata with mutagen-inspect (if available)
    if command -v mutagen-inspect >/dev/null 2>&1; then
        mutagen-inspect "$f" | sed -n '1,200p'
        exit 0
    fi

    # Last fallback: show a couple of lines of 'mediainfo' / 'ffprobe' if available
    if command -v ffprobe >/dev/null 2>&1; then
        ffprobe -v error -show_entries format_tags=artist,album,title -of default=noprint_wrappers=1:nokey=0 "$f" 2>/dev/null | sed -n '1,200p'
        exit 0
    fi

    # Nothing else available:
    echo "(no cover found, and no metadata tool available to show tags)"
    exit 0
}

export -f _preview_cmd

fd_cmd=(fd --type f --hidden --exclude .git . "$HOME/Music")

# fzf preview invocation uses bash -c '_preview_cmd {}'
# preview-window and layout options are adjustable.
chosen_files="$(
    "${fd_cmd[@]}" | fzf \
        --height 40% \
        --reverse \
        --multi
)"

[ -z "$chosen_files" ] && echo "No files selected." && exit 0

# Iterate and set BPM. For MP3 use mid3v2 --TBPM (Mutagen's tool).
while IFS= read -r f; do
    case "${f,,}" in
    *.mp3)
        if command -v mid3v2 >/dev/null 2>&1; then
            mid3v2 --TBPM "$bpm" "$f" && echo "Wrote BPM $bpm -> $f"
        else
            echo "mid3v2 not found; cannot tag $f"
        fi
        ;;
    *.flac)
        if command -v metaflac >/dev/null 2>&1; then
            metaflac --remove-tag=BPM --set-tag="BPM=$bpm" "$f" && echo "Wrote BPM $bpm -> $f"
        else
            echo "metaflac not found; cannot tag $f"
        fi
        ;;
    *.ogg)
        if command -v vorbiscomment >/dev/null 2>&1; then
            # -a append tag, overwrite previous BPM if present with -w? vorbiscomment doesn't overwrite by default; remove then write:
            vorbiscomment -l "$f" | sed '/^BPM=/d' >/tmp/vc.$$ || true
            echo "BPM=$bpm" >>/tmp/vc.$$
            vorbiscomment -w -c /tmp/vc.$$ "$f" && echo "Wrote BPM $bpm -> $f"
            rm -f /tmp/vc.$$
        else
            echo "vorbiscomment not found; cannot tag $f"
        fi
        ;;
    *.m4a | *.mp4)
        # try AtomicParsley first (writes tmpo)
        if command -v AtomicParsley >/dev/null 2>&1; then
            AtomicParsley "$f" --tmpo "$bpm" --overWrite && echo "Wrote BPM $bpm -> $f"
        elif python -c "import mutagen" >/dev/null 2>&1; then
            # quick mutagen-based python snippet
            python - <<PY
from mutagen.mp4 import MP4
f = "$f"
mp4 = MP4(f)
mp4.tags["tmpo"] = [int(float("$bpm"))]
mp4.save()
print("Wrote BPM $bpm ->", f)
PY
        else
            echo "no mp4 tagging tool found for $f"
        fi
        ;;
    *)
        echo "Unsupported file type: $f"
        ;;
    esac
done <<<"$chosen_files"
