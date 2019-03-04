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
    dircolors -c ~/.dircolors | source
else
    dircolors -c | source
end

source ~/.config/fish/hooks.fish

set -x LC_ALL en_US.UTF-8
set -x fish_user_paths ~/bin /usr/local/bin $fish_user_paths

alias lh 'ls -lh'
alias zsh 'env NOFISH=1 zsh'
alias g 'git'
alias get 'sudo apt-get install'
alias remove 'sudo apt-get remove'
