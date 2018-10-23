if status is-login
    switch (tty)
        case /dev/tty1
            exec startx > /dev/null
        case /dev/tty2
            exec env SESSION=emacs startx > /dev/null
    end
end

if not status is-interactive
    exit
end


function __postexec_bell --on-event fish_postexec
    printf '\a'
end

function __cwd_to_urxvt --on-variable PWD
    set -l update \033"]777;cwd-spawn;path;$PWD"\007

    switch $TERM
        case "rxvt-unicode*"
            echo -n $update
    end
end
__cwd_to_urxvt

function history-fzf
    history | fzf --multi | fish --interactive
end

alias lh 'ls -lh'
alias annex 'git annex'
alias ql quilt
alias printl 'printf \'%s\n\''
alias zsh 'env NOFISH=1 zsh'