#!/usr/bin/env bash
# Log filename may be passed as an argument optionally.
# If none passed, the new log file will be created per the configuration
# guide.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"


start_pipe_pane() {
	local fname=$(expand_tmux_format_path "${logging_full_filename}")
	local file=${1:-$fname}
	"$CURRENT_DIR/start_logging.sh" "${file}"
	display_message "Started logging to ${file}"
}

stop_pipe_pane() {
	tmux pipe-pane
	display_message "Ended logging to $logging_full_filename"
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
		start_pipe_pane $1
	fi
}

main() {
	if supported_tmux_version_ok; then
		toggle_pipe_pane $1
	fi
}
# if argument is passed, treat it as the logfilename
main $1
