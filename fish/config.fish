## ENVIRONMENT VARIABLES ##
eval (dircolors -c | sed 's/^setenv/set -x/')

## RUN ON INIT SHELL ##
if status --is-login
    if test (tty) = /dev/tty1
        Hyprland
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    mise activate fish | source
end

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
