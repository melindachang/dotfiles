function low_battery_alert
    while true
        set bat /sys/class/power_supply/BAT0
        set level (cat $bat/capacity)
        set status (cat $bat/status)
        if test $bat_level -le 20; and test status != Charging
            notify-send -u critical "Battery Low" "Level: $bat_level%"
            sleep 1200
        else
            sleep 120
        end
    end
end
