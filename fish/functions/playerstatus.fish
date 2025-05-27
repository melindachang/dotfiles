function playerstatus --description "player status"
  set opt --player=spotify,firefox
  set mpris_status (playerctl $opt status)
  
  if test $mpris_status!="No players found"
    set text (playerctl $opt metadata --format "{{title}} - {{ artist }}")
    set tooltip (playerctl $opt metadata --format "{{ playerName }}: {{ album }}")

    # if test $mpris_status = "Playing"
    #   set icon "  "
    # else if test $mpris_status = "Paused"
    #   set icon "  "
    # end 
  end
  echo '{"text": "'"$text"'", "tooltip": "'"$tooltip"'", "class": "'"$mpris_status"'"}'
end

# function playerstatus --description "player status"
#   set mpd_status (mpc current --host 127.0.0.1 --port 6002)
#   set mpris_status (playerctl status)
#   if test (pgrep -c ncmpcpp) -gt 0
#     set text $mpd_status
#     set tooltip "mpd - playing"
#     set mpris_status "Music"
#   else if test $mpris_status!="No players found"
#     set text (playerctl metadata title)
#     set tooltip (playerctl metadata --format "{{ playerName }} : {{ title }}")
#   end
#     echo '{"text": "'"$text"'", "alt": "'"$mpris_status"'", "tooltip": "'"$tooltip"'", "class": "'"$mpris_status"'" }'
# end
