function gg --wraps=git
    set -l height 30
    if test "$LINES" -lt 33
        set height (math $LINES - 3)
    end
    git g $argv -n $height
end
