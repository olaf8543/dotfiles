# Ensure zoxide is installed before defining wrappers
if type -q zoxide
    function zd
        # no args -> go home
        if test (count $argv) -eq 0
            builtin cd ~
            return 0
        end

        # first arg is an existing dir -> normal cd
        if test -d $argv[1]
            builtin cd -- $argv[1]
            return 0
        end

        # otherwise ask z (zoxide) to jump; if it succeeds, print glyph + cwd
        z $argv; and printf '%s %s\n' '󱞩' (pwd); or echo 'Error: Directory not found'
    end

    # make plain `cd` call the zd wrapper (mirrors alias cd="zd" in bash)
    function cd
        zd $argv
    end
end
