function wp:themes () {
    if [ -d "wp-content/themes" ]; then
        cd "wp-content/themes"
    elif [ -d "wordpress/wp-content/themes" ]; then
        cd "wordpress/wp-content/themes"
    fi
}
alias wpt='wp:themes'

function wppc () { wp post create --post_type=page --post_status=publish --post_title=$1 }
