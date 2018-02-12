capture_pane() {
	local capture_scope=$1
	if [ $capture_scope == "History" ]; then
		local file=$(tmux display-message -p "$save_complete_history_full_filename")
		local path=$(tmux display-message -p "$save_complete_history_path")
		mkdir -p "$path"
		local history_limit="$(tmux display-message -p -F "#{history_limit}")"
		tmux capture-pane -J -S "-${history_limit}" -p > "$file"
	elif [[ $capture_scope == "Screen capture" ]]; then
		local file=$(tmux display-message -p "$screen_capture_full_filename")
		local path=$(tmux display-message -p "$screen_capture_path")
		mkdir -p "$path"
		tmux capture-pane -J -p > "$file"
	else
		# error
		exit 1
	fi
	remove_empty_lines_from_end_of_file "$file"
	display_message "$capture_scope saved to $file"
}
