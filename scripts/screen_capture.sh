#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"

main() {
	if supported_tmux_version_ok; then
		local file=$(expand_tmux_format_path "${screen_capture_full_filename}")
		tmux capture-pane -J -p > "${file}"
		remove_empty_lines_from_end_of_file "${file}"
		display_message "Screen capture saved to ${file}"
	fi
}
main
