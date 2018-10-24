function git --wraps=git
    if not set -q argv[1]
        set argv status --short
    end
    command git $argv
end
