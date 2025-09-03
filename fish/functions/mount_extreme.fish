function mount_extreme
    # sudo mount -t exfat -o uid=1000,gid=1000,umask=0022 UUID=E88E-EF74 /mnt/EXTREME_SSD
    sudo mount -t exfat \
        -o uid=1000,gid=$(getent group media | cut -d: -f3),umask=0002 \
        UUID=E88E-EF74 /mnt/EXTREME_SSD
end
