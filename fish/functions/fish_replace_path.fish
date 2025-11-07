function fish_replace_path -a old_path new_path
    set old_path (realpath -m $old_path)

    set -l normalized_paths
    for p in $fish_user_paths
        set -a normalized_paths (realpath -m $p)
    end

    if contains -i $old_path $normalized_paths
        echo "Removing $old_path from fish_user_paths."
        read -l -P 'Continue? [y/N]: ' confirm

        if test (string lower -- $confirm) != y
            return
        end
    else
        echo "Path not found."
        return
    end

    while set -l idx (contains -i $old_path $normalized_paths)
        set -e fish_user_paths[$idx]
        set -e normalized_paths[$idx]
    end

    if test -n "$new_path"
        fish_add_path (realpath -m $new_path)
    end
end
