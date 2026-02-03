function _conditional_fetch
    if not set -q TMUX
        if not set -q TERM_PROGRAM || test "$TERM_PROGRAM" != vscode
            fetch
        end
    end
end
