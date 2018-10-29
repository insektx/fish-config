# Do *not* add --wrap, the fish completion for quilt is broken and
# doesn't complete the paths, only the commands, making more harm than
# good.
function ql
    quilt $argv
end
