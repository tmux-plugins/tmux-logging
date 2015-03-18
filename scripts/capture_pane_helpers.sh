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
		local history_limit="$(tmux display-message -p -F "#{history_limit}")"
		tmux capture-pane -J -S "-${history_limit}" -p > "$file"
	elif [[ $capture_scope == "Screen capture" ]]; then
		tmux capture-pane -J -p > "$file"
	else
		# error
		exit 1
	fi
	remove_empty_lines_from_end_of_file "$file"
	display_message "$capture_scope saved to $file"
}
