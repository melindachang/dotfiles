function low_battery_alert
    while true
        set bat_level (pwr)
        if test $bat_level -le 20
            notify-send "Battery Low" "Level: $bat_level%"
            sleep 1200
        else
            sleep 120
        end
    end
end
