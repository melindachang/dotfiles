set VALID_THEMES gruvbox_material catppuccin_mocha tokyo_night

function _switch_zellij_theme -a theme
    set config_path ~/.config/zellij/config.kdl

    switch $theme
        case tokyo_night
            set format tokyo-night-dark
        case catppuccin_mocha
            set format catppuccin-mocha
        case gruvbox_material
            set $format gruvbox-dark
    end

    sed -i -E "s/(theme \")[a-z-]+\"/\1$format\"/1" $config_path
end

function _switch_waybar_theme -a theme
    set config_path ~/.config/waybar/style.css

    sed -i -E "s/(@import \"themes\/)[a-z_]+(\.css\")/\1$theme\2/1" $config_path

    hyprctl reload
    pkill waybar
    hyprctl dispatch exec waybar
end

function _switch_rofi_theme -a theme
    set config_path ~/.config/rofi/theme.rasi

    sed -i -E "s/(@import \"themes\/)[a-z_]+\"/\1$theme\"/g" $config_path
end

function _switch_foot_theme -a theme
    set config_path ~/.config/foot/foot.ini

    sed -i -E "s/(include=~\/\\.config\/foot\/themes\/)[a-z_]+\\.ini/\\1$theme\\.ini/1" $config_path
end

function _switch_neovim_theme -a theme
    set config_path ~/.config/nvim/init.lua

    switch $theme
        case tokyo_night
            set formatted tokyonight-night
        case '*'
            set formatted (string replace _ - $theme)
    end

    sed -i -E "s/(vim\\.cmd\\.colorscheme\\s+)'[a-zA-Z0-9_-]+'/\\1'$formatted'/g" $config_path
end

function _switch_emacs_theme -a theme
    set config_path ~/.emacs.d/init.el
    # set config_path $DOOMDIR/config.el
    #
    # switch $theme
    #     case tokyo_night
    #         set name doom-tokyo
    #     case catppuccin_mocha
    #         set name catppuccin
    #     case gruvbox_material
    #         set name doom-gruvbox
    # end
    #
    # sed -i -E "s/(\(setq doom-theme ')[a-z_-]+\)/\1$name\)/g" $config_path
end

# function _switch_code_theme -a theme
#   set config_path ~/.config/Code/User/settings.json
#
#   switch $theme
#     case tokyo_night
#       set name "Tokyo Night"
#     case catppuccin_mocha
#       set name "Catppuccin Mocha"
#     case gruvbox_material
#       set name "Gruvbox Dark Medium"
#   end
#
#   sed -i -E "s/(\"workbench.colorTheme\": \")[a-zA-Z\s_-]+\"/\1$name\"/g" $config_path
# end

function _switch_swaync_theme -a theme
    set config_path ~/.config/swaync/style.css

    sed -i -E "s/(@import \"themes\\/)[a-z_]+(\\.css\";)/\1$theme\2/1" $config_path

    swaync-client -rs
end

function _switch_zathura_theme -a theme
    set config_path ~/.config/zathura/zathurarc
    sed -i -E "s/^(include themes\/)[a-z_]+\$/\1$theme/1" $config_path
end

function _switch_spotify_theme -a theme
    if test $theme = gruvbox_material
        set format Gruvbox
    else
        for part in (string split _ $theme)
            set -a format (string upper (string sub -l 1 $part))(string sub -s 2 $part)
        end
    end
    command spicetify config color_scheme (string join "" $format)
    command spicetify apply
end

function _switch_btop_theme -a theme
    set config_path ~/.config/btop/btop.conf

    sed -i -E "s/^(color_theme = \")[a-z_]+\"/\1$theme\"/1" $config_path
end

function _switch_yazi_theme -a theme
    set config_path ~/.config/yazi/theme.toml

    if test $theme = gruvbox_material
        set format gruvbox-dark
    else
        set format (string replace _ - $theme)
    end
    sed -i -E "s/^(dark = \")[a-z-]+\"/\1$format\"/1" $config_path
end

function switch_system_theme -a theme
    if contains $theme $VALID_THEMES
        begin
            _switch_waybar_theme $theme
            _switch_rofi_theme $theme
            _switch_foot_theme $theme
            _switch_neovim_theme $theme
            _switch_emacs_theme $theme
            # _switch_code_theme $theme
            _switch_zathura_theme $theme
            _switch_spotify_theme $theme
            _switch_yazi_theme $theme
            _switch_btop_theme $theme
            _switch_swaync_theme $theme
            _switch_zellij_theme $theme
            switch_wallpaper $theme
        end &>/dev/null
    else
        echo Invalid theme!
    end
end
