alias wp:themes='cd wp-content/themes'

function wppc () { wp post create --post_type=page --post_status=publish --post_title=$1 }
