## set up SSH pushing to codeberg ##
function berg_migrate -a repo
    set remotes (string trim (string replace origin '' (git remote -v)))
    set opt
    for r in $remotes
        if begin
                string match -q -r '(.*) \(push\)' $r; and string match -q -r github $r
            end
            set opt --add
        end
    end
    git remote set-url $opt --push origin "git@codeberg.org:melindachang/$repo.git"
end
