if status is-login
    switch (tty)
        case /dev/tty1
            exec startx -- vt1 > /dev/null
        case /dev/tty2
            exec env SESSION=emacs startx -- vt2 > /dev/null
    end
end

if not status is-interactive
    exit
end

# Initialize the pretty ls(1) colors if available.
if test -r ~/.dircolors
    source (dircolors -c ~/.dircolors | psub)
else
    source (dircolors -c | psub)
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
alias printl 'printf \'%s\n\''
alias zsh 'env NOFISH=1 zsh'
