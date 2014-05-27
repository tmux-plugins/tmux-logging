# Variables in this helper should be set in the file sourcing the helper.
# Required variables:
# - path_option & default_path
# - name_option & default_name

get_path() {
	get_tmux_option "$path_option" "$default_path"
}

# `tmux save-buffer` command does not perform interpolation, so we're doing it
# "manually" with `display-message`
get_filename() {
	local name_template=$(get_tmux_option "$name_option" "$default_name")
	tmux display-message -p "$name_template"
}

capture_pane() {
	local file="$(get_path)/$(get_filename)"
	local capture_scope=$1
	if [ $capture_scope == "History" ]; then
		# copying 9M lines back will hopefully fetch the whole scrollback
		tmux capture-pane -S -9000000
	elif [[ $capture_scope == "Screen capture" ]]; then
		tmux capture-pane
	else
		# error
		exit 1
	fi
	tmux save-buffer "$file"
	tmux delete-buffer
	remove_empty_lines_from_end_of_file "$file"
	display_message "$capture_scope saved to $file"
}
