#!/bin/fish

# HARDCODE Location
set config_path ~/.config/hypr/hyprlock.conf

set city (rg -oP '^\$CITY\s*=\s*\K.+' $config_path)
set country (rg -oP '^\$COUNTRY\s*=\s*\K.+' $config_path)

# Check if CITY and COUNTRY are valid
if test -n $city; and test -n $country
    # Fetch weather info for the detected city from wttr.in
    set weather_info (curl -s "wttr.in/$city?format=%c+%C+%t" 2>/dev/null)
    set fmt (string join '' (string replace _ ' ' $city) ', ' $country)

    # Check if the weather info is valid
    if test -n $weather_info
        echo "$fmt: $weather_info"
    else
        echo "Weather info unavailable for $fmt"
    end
else
    echo "Unable to determine your location"
end
