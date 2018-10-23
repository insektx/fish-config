function gr
    set gitroot (git rev-parse --show-toplevel)
    if test -z "$gitroot"
        set gitroot (pwd | sed 's:/.git\(/.*\|$\)::')
    end
    cd $gitroot
end
