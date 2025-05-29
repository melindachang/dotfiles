function paru
    if test "$argv[1]" = -Rs
        set args $argv[2..-1]
        sudo pacman -Rs $args
    else
        command paru $argv
    end
end
