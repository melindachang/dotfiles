function mvdir -a src dest
    if test -d $src
        if test ! -d $dest
            mkdir -p $dest
        end
    else
        set dest_dir (dirname $dest)
        if test ! -d $dest_dir
            mkdir -p $dest_dir
        end
    end
    mv $src $dest
end
