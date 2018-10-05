function ftw_repeat() {
    echo $(printf "%.0s$1" $(seq 1 $2))
}

function ftw_init_cd_liases() {
    for i in $(seq 1 $1); do
        local alias_dots=$(ftw_repeat . $i)
        local cd_command="cd $(ftw_repeat ../ $i)"
        alias "cd$alias_dots"=$cd_command
        alias "cdl$alias_dots"="$cd_command && ls"
    done
}

ftw_init_cd_liases 10
