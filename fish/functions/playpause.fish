function playpause --description "play pause"
    set opt --player=spotify,firefox

    if test (playerctl $opt status) != "No players found"
        command playerctl $opt play-pause
    end
end
