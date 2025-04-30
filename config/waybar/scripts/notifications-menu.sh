#!/usr/bin/env bash

# Define close_all variable to match menu entry
close_all="Clear Notifications"

history_json=$(dunstctl history)

# Arrays to store menu entries and notification IDs
menu_entries=()
notification_ids=()

# Process notifications in ORIGINAL order (newest first)
while IFS=$'\t' read -r id summary message; do
    # Clean HTML tags from message
    clean_message=$(echo "$message" | sed -e 's/<[^>]*>//g')

    # Format the notification text
    if [[ -z "$summary" && -z "$clean_message" ]]; then
        entry="Notification $id"
    else
        [[ -n "$summary" ]] && entry="$summary" || entry=""
        [[ -n "$clean_message" ]] && entry="${entry:+$entry: }$clean_message"
    fi

    menu_entries+=("$entry")
    notification_ids+=("$id")
done < <(echo "$history_json" | jq -r '.data[0][] | [.id.data, .summary.data // "", .message.data // ""] | @tsv')

menu_entries+=("$close_all")

selected=$(printf '%s\n' "${menu_entries[@]}" | fuzzel --dmenu \
    --config ~/.config/fuzzel/notifications/fuzzel.ini \
    --log-level=warning \
    --lines=10)

# Handle selection
if [[ "$selected" == "$close_all" ]]; then
    dunstctl history-clear
elif [[ -n "$selected" ]]; then
    # Find the index of the selected entry
    for i in "${!menu_entries[@]}"; do
        if [[ "${menu_entries[$i]}" == "$selected" ]]; then
            if (( i > 0 )); then
                # Use correct index mapping
                dunstctl history-rm "${notification_ids[$((i-1))]}"
            fi
            break
        fi
    done
fi
