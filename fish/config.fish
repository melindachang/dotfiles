if status --is-login
  if test (tty) = /dev/tty1
    Hyprland
  end
end

if status is-interactive
# Commands to run in interactive sessions can go here
# krabby random | tail -n +2
end

## ENVIRONMENT VARIABLES ##

set -x BAT_THEME "gruvbox-dark"
set fzf_fd_opts "-u"

# ALIASES - CONVENIENCE ##

alias ..="cd .."
alias cd..="cd .."

alias ussh="ssh hychang@lycus.usbx.me"
alias ulftp="lftp sftp://hychang@lycus.usbx.me"

alias editc="nvim $HOME/.config/fish/config.fish"
alias sourcec="source $HOME/.config/fish/config.fish"
alias pwr="cat /sys/class/power_supply/BAT0/capacity"

## ALIASES - TOOL REPLACEMENT ##

alias l="eza"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"

## RUN ON INIT SHELL ##
zoxide init fish | source

starship init fish | source

source ~/.local/share/icons-in-terminal/icons.fish

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/melinda/.ghcup/bin # ghcup-env
