#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_log_path="$HOME"
default_log_name="tmux-#S-#I-#P-%Y%m%dT%H%M%S.log"

log_path_option="@pipe_pane_path"
log_name_option="@pipe_pane_filename"

source $CURRENT_DIR/shared.sh

get_log_path() {
	get_tmux_option "$log_path_option" "$default_log_path"
}

get_log_name() {
	get_tmux_option "$log_name_option" "$default_log_name"
}

start_pipe_pane() {
	local file="$(get_log_path)/$(get_log_name)"
	$CURRENT_DIR/tmux_start_pipe_pane.sh "$file"
	display_message "Started logging to $file"
}

stop_pipe_pane() {
	local file="$(get_log_path)/$(get_log_name)"
	tmux pipe-pane
	display_message "Ended logging to $file"
}

# returns a string unique to current pane
pane_unique_id() {
	tmux display-message -p "#S_#I_#P"
}

# saving 'logging' 'not logging' status in a variable unique to pane
set_logging_variable() {
	local value=$1
	local pane_unique_id="$(pane_unique_id)"
	tmux set-option -gq "@$pane_unique_id" "$value"
}

# this function checks if logging is happening for the current pane
is_logging() {
	local pane_unique_id="$(pane_unique_id)"
	local current_pane_logging=$(get_tmux_option "@$pane_unique_id" "not logging")
	if [ $current_pane_logging == "logging" ]; then
		return 0
	else
		return 1
	fi
}

# starts/stop logging
toggle_pipe_pane() {
	if is_logging; then
		set_logging_variable "not logging"
		stop_pipe_pane
	else
		set_logging_variable "logging"
		start_pipe_pane
	fi
}

main() {
	toggle_pipe_pane
}
main
