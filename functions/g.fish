function g --wraps=git
    if not set -q argv[1]
        set argv status --short
    end
    git $argv
end
