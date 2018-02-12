#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/shared.sh"


setup_logging_key_binding() {
	tmux bind-key "$logging_key" run-shell "$CURRENT_DIR/scripts/toggle_logging.sh"
}

setup_screen_capture_key_binding() {
	tmux bind-key "$pane_screen_capture_key" run-shell "$CURRENT_DIR/scripts/screen_capture.sh"
}

setup_save_complete_history_key_binding() {
	tmux bind-key "$save_complete_history_key" run-shell "$CURRENT_DIR/scripts/save_complete_history.sh"
}

setup_clear_history_key_binding() {
	tmux bind-key "$clear_history_key" run-shell "$CURRENT_DIR/scripts/clear_history.sh"
}

main() {
	setup_logging_key_binding
	setup_screen_capture_key_binding
	setup_save_complete_history_key_binding
	setup_clear_history_key_binding
}
main
