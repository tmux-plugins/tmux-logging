get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo $default_value
	else
		echo $option_value
	fi
}

# Ensures a message is displayed for 5 seconds in tmux prompt
display_message() {
	local message=$1

	# display_duration defaults to 5 seconds, if not passed as an argument
	if [ "$#" -eq 2 ]; then
		local display_duration=$2
	else
		local display_duration="5000"
	fi

	# saves user-set 'display-time' option
	local saved_display_time=$(get_tmux_option "display-time" "750")

	# sets message display time to 5 seconds
	tmux set-option -gq display-time "$display_duration"

	# displays message
	tmux display-message "$message"

	# restores original 'display-time' value
	tmux set-option -gq display-time "$saved_display_time"
}

# simplest solution, taken from here: http://unix.stackexchange.com/a/81689
remove_empty_lines_from_end_of_file() {
	local file=$1
	local temp=$(cat $file)
	printf '%s\n' "$temp" > "$file"
}

supported_tmux_version_ok() {
	$CURRENT_DIR/check_tmux_version.sh "$SUPPORTED_VERSION"
}

# Checking full path to logfile and expanding tmux format in normal path
# As example: expand %Y-%m-%d to current date
expand_tmux_format_path() {
	local tmux_format_path=$1
	local full_path=$(tmux display-message -p "${tmux_format_path}")
	local full_directory_path=${full_path%/*}
	mkdir -p "${full_directory_path}"
	echo "${full_path}"
}
