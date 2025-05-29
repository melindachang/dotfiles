function clamshell_mode -a s
    if string match -q "*HDMI-A-1*" (hyprctl monitors)
        if test $s = open
            hyprctl keyword monitor "eDP-1,preferred,1920x0,1.6"
        else
            # $s = closed
            hyprctl keyword monitor "eDP-1,disable"
        end
    end
end
