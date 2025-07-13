function camel_to_kebab
    set input (string trim $argv[1])

    # dash between lowercase and uppercase letters
    set input (string replace -r -a '([a-z])([A-Z])' '\1-\2' -- $input)

    # dash between letter and digits
    set input (string replace -r -a '([a-zA-Z])([0-9])' '\1-\2' -- $input)

    # dash between digits and letters
    set input (string replace -r '([0-9])([a-zA-Z])' '\1-\2' -- $input)

    echo (string lower $input)
end
