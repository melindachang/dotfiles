## ENVIRONMENT VARIABLES ##
eval (dircolors -c | sed 's/^setenv/set -x/')

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    mise activate fish | source
end

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
