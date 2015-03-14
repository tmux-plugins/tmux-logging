#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Functions defined in capture_pane_helpers are customized via below variables.
default_path="$HOME"
default_name="tmux-screen-capture-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log"

path_option="@screenshot_path"
name_option="@screenshot_filename"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"
source "$CURRENT_DIR/capture_pane_helpers.sh"

main() {
	if supported_tmux_version_ok; then
		capture_pane "Screen capture"
	fi
}
main
