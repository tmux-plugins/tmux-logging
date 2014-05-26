#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_log_path="$HOME"
default_log_name="tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log"

source $CURRENT_DIR/shared.sh

get_log_path() {
	get_tmux_option "@ppp_path" "$default_log_path"
}

get_log_name() {
	get_tmux_option "@ppp_name" "$default_log_name"
}

ansifilter_installed() {
	type ansifilter >/dev/null 2>&1 || return 1
}

system_osx() {
	[ $(uname) == "Darwin" ]
}

start_pipe_pane() {
	local log_path=$(get_log_path)
	local log_name=$(get_log_name)
	if ansifilter_installed; then
		tmux pipe-pane "exec cat - | ansifilter >> $log_path/$log_name"
	elif system_osx; then
		# OSX uses sed '-E' flag and a slightly different regex
		# Warning, very complex regex ahead.
		# Some characters below might not be wisible from github web view.
		tmux pipe-pane "exec cat - | sed -E \"s/(\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]||]0;[^]+|[[:space:]]+$)//g\" >> $log_path/$log_name"
	else
		tmux pipe-pane "exec cat - | sed -r 's/(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]|)//g' >> $log_path/$log_name"
	fi
	display_message "Started logging to $log_path/$log_name"
}

stop_pipe_pane() {
	local log_path=$(get_log_path)
	local log_name=$(get_log_name)
	tmux pipe-pane
	display_message "Ended logging to $log_path/$log_name"
}

pane_unique_id() {
	tmux display-message -p "#{session_name}_#{window_index}_#{pane_index}"
}

set_logging_variable() {
	local value=$1
	local pane_unique_id="$(pane_unique_id)"
	tmux set-option -gq "@$pane_unique_id" "$value"
}

is_logging() {
	local pane_unique_id="$(pane_unique_id)"
	local current_pane_logging=$(get_tmux_option "@$pane_unique_id" "not logging")
	if [ $current_pane_logging == "logging" ]; then
		return 0
	else
		return 1
	fi
}

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
