#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"
source "$CURRENT_DIR/capture_pane_helpers.sh"

# Functions defined in capture_pane_helpers are customized via below variables.
default_path="$default_save_complete_history_path"
default_name="$default_save_complete_history_filename"

path_option="$save_complete_history_path_option"
name_option="$save_complete_history_filename_option"

main() {
	if supported_tmux_version_ok; then
		capture_pane "History"
	fi
}
main
