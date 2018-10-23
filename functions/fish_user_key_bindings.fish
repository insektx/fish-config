function fish_user_key_bindings
    fzf_key_bindings

    function prepend-space
        set cmd (commandline)
        if test -n "$cmd"
            commandline --replace " "(string trim $cmd)
        end
    end
    bind \e" " prepend-space

    function __ranger-cd
        set tempfile (mktemp -t tmp.XXXXXX)
        ranger --choosedir=$tempfile (pwd)
        if test -f $tempfile
            cd (cat $tempfile)
        end
        rm -f -- $tempfile
        commandline -f repaint
    end
    bind \er __ranger-cd

    function __most_recent_file
        set arg (commandline --current-token)

        set candidates $arg*
        if test (count $candidates) = 0
            return
        end

        set sorted (ls -td $candidates)
        commandline --replace --current-token (string escape $sorted[1])
    end
    bind \cxm __most_recent_file

    function __change_history_file
        read -P (set_color green)"history"(set_color normal)"> " fish_history
        if [ -z "$fish_history" ]
            set -e fish_history
        end
        commandline -f repaint
    end
    bind \cxh __change_history_file

    function __accept-and-hold
        set cmd (commandline)
        set cursor (commandline --cursor)
        commandline -f execute
        function __accept-and-hold-callback \
            --inherit-variable cmd          \
            --inherit-variable cursor       \
            --on-event fish_postexec

            functions --erase __accept-and-hold-callback
            commandline --replace $cmd
            commandline --cursor $cursor
            set -e cmd
        end
    end
    bind \ea __accept-and-hold
end