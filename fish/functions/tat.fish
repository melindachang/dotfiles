function tat
    set name (string replace -r '\.' '' (basename (pwd)))

    if tmux has-session -t "$name" 2>/dev/null
        tmux attach -t "$name"
    else
        tmux new-session -s "$name"
    end
end
