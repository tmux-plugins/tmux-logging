#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/shared.sh"

setup_logging_key_binding() {
	local key=$(get_tmux_option "$logging_key_option" "$default_logging_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/toggle_logging.sh"
}

setup_pane_screenshot_key_binding() {
	local key=$(get_tmux_option "$pane_screen_capture_key_option" "$default_pane_screen_capture_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/screen_capture.sh"
}

setup_scrollback_dump_key_binding() {
	local key=$(get_tmux_option "$save_complete_history_key_option" "$default_save_complete_history_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/save_complete_history.sh"
}

setup_clear_scrollback_key_binding() {
	local key=$(get_tmux_option "$clear_history_key_option" "$default_clear_history_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/clear_history.sh"
}

main() {
	setup_logging_key_binding
	setup_pane_screenshot_key_binding
	setup_scrollback_dump_key_binding
	setup_clear_scrollback_key_binding
}
main
