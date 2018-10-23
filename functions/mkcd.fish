function mkcd --wraps=mkdir
    mkdir -p $argv
    and cd $argv
end
