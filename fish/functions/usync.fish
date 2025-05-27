
function usync -a src dest
  command rsync -aHAXxv --numeric-ids --info=progress2 --bwlimit=20000 hychang@lycus.usbx.me:/home/hychang/downloads/qbittorrent/$src $dest
end
