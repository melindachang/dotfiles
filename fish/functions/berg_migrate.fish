function berg_migrate -a repo
    if test -z $repo
        echo 'Error: missing repo argument'
        echo "Usage: berg_migrate <codeberg-repo-name>"
        return 1
    end

    if not git rev-parse --is-inside-work-tree ^/dev/null
        echo "Error: not a git repository"
        return 1
    end

    if not git remote get-url origin ^/dev/null
        echo "Error: no 'origin' remote found"
        return 1
    end

    set remotes (git remote -v)

    set should_add 0

    # Detect GitHub push URL on origin
    for line in $remotes
        if string match -q "origin*" $line
            if string match -q "*github.com*" $line; and string match -q "*(push)" $line
                set should_add 1
            end
        end
    end

    if test $should_add -ne 1
        echo "No GitHub push URL found on origin."
        return 0
    end

    set new_url "git@codeberg.org:name/$repo.git"

    echo "Adding push URL to origin:"
    echo "  $new_url"
    echo -n "Continue? (y/N) "
    read -l ans
    if test "$ans" != y
        echo "Aborting."
        return 0
    end

    git remote set-url --add --push origin "$new_url"

    echo "Added push URL."
end
