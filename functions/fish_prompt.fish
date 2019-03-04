function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l suffix

    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
            set color_user red
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
            set color_user green
    end

    if test -n "$SSH_TTY"
        set prompt_hostname \
        (set_color --bold yellow) (prompt_hostname) (set_color normal)
    else
        set prompt_hostname \
        (set_color yellow) (prompt_hostname) (set_color normal)
    end

    echo -n -s (set_color $color_user) "$USER" (set_color normal) \
    @ $prompt_hostname ' ' \
    (set_color $color_cwd) (prompt_pwd) (set_color normal)

    set -l git_prompt yes
    for pattern in $fish_prompt_git_ignored_patterns
        if string match -q "$pattern" "$PWD"
            set git_prompt no
            break
        end
    end

    if test $git_prompt = yes
      set -g __fish_git_prompt_char_cleanstate "✔"
      set -g __fish_git_prompt_char_conflictedstate "✖"
      set -g __fish_git_prompt_char_dirtystate "✚"
      set -g __fish_git_prompt_char_stagedstate "●"
      set -g __fish_git_prompt_char_untrackedfiles " *"
      set -g __fish_git_prompt_color_branch yellow
      set -g __fish_git_prompt_color_cleanstate green
      set -g __fish_git_prompt_color_dirtystate red
      set -g __fish_git_prompt_color_invalidstate red
      set -g __fish_git_prompt_color_stagedstate blue
      set -g __fish_git_prompt_color_untrackedfiles red
      set -g __fish_git_prompt_hide_untrackedfiles 1
      set -g __fish_git_prompt_show_informative_status 1
      set -g __fish_git_prompt_showupstream "none"

      echo -n -s (__fish_git_prompt)
    end

    echo -n -s $prompt_suffix \
    $suffix_color[1] $suffix $suffix_color[2] ' '
end
