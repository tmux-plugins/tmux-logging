#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"
source "$CURRENT_DIR/capture_pane_helpers.sh"

# Functions defined in capture_pane_helpers are customized via below variables.
default_path="$default_logging_path"
default_name="$default_logging_filename"

path_option="$logging_path_option"
name_option="$logging_filename_option"

start_pipe_pane() {
	local filename="$(get_path)/$(get_filename)"
	"$CURRENT_DIR/start_logging.sh" "$filename"
	display_message "Started logging to $filename"
}

stop_pipe_pane() {
	tmux pipe-pane
	display_message "Ended logging to $(get_filename)"
}

# returns a string unique to current pane
pane_unique_id() {
	tmux display-message -p "#{session_name}_#{window_index}_#{pane_index}"
}

# saving 'logging' 'not logging' status in a variable unique to pane
set_logging_variable() {
	local value="$1"
	local pane_unique_id="$(pane_unique_id)"
	tmux set-option -gq "@${pane_unique_id}" "$value"
}

# this function checks if logging is happening for the current pane
is_logging() {
	local pane_unique_id="$(pane_unique_id)"
	local current_pane_logging="$(get_tmux_option "@${pane_unique_id}" "not logging")"
	if [ "$current_pane_logging" == "logging" ]; then
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
	if supported_tmux_version_ok; then
		toggle_pipe_pane
	fi
}
main
