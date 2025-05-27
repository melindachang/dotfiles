
function desktop-edit -a f
  if not test -e ~/.local/share/applications/$f.desktop 
    command sudo cp /usr/share/applications/$f.desktop ~/.local/share/applications/$f.desktop
  end
  command nvim ~/.local/share/applications/$f.desktop
end
