function restart_emacs
    pkill emacs
    hyprctl dispatch exec "emacs --daemon"
end
