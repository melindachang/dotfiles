function handle_floating_window
    # Resizes floating windows

    hyprctl dispatch togglefloating

    set -l window (hyprctl activewindow)

    if test 1 -eq (string match -rg 'floating: (\d+)' $window)
        switch (string match -rg 'class: (\w+)' $window)
            case foot
                if test cava = (string match -rg 'title: (\w+)' $window)
                    hyprctl dispatch resizeactive exact 32% 35%
                else
                    hyprctl dispatch resizeactive exact 60% 70%
                end
            case '*'
                hyprctl dispatch resizeactive exact 90% 85%
        end
        hyprctl dispatch centerwindow
    end
end
