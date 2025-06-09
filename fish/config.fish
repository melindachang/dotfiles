## ENVIRONMENT VARIABLES ##
set -x BAT_THEME gruvbox-dark
set fzf_fd_opts -u

source ~/.local/share/icons-in-terminal/icons.fish

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/melinda/.ghcup/bin # ghcup-env

## RUN ON INIT SHELL ##

zoxide init fish | source
starship init fish | source

if status --is-login
    if test (tty) = /dev/tty1
        Hyprland
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
