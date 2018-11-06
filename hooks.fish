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

# WINDOWID is set by xterm like terminals
if test "$SESSION" = "emacs" -a -n "$WINDOWID"
    set -l exwm_check (emacsclient -n -a false --eval "(featurep 'exwm)" 2> /dev/null)
    if test "$exwm_check" = t
        function __exwm_chpwd --on-variable PWD
            set quoted_pwd \"(string replace '"' '\\"' (string replace "\\" "\\\\" $PWD/))\"
            emacsclient -n -e "
            (if-let ((buffer (exwm--id->buffer $WINDOWID)))
              (with-current-buffer buffer
                (setq default-directory $quoted_pwd)))
            " > /dev/null
        end
        __exwm_chpwd
    end
end
