#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/shared.sh"

setup_pipe_pane_key_binding() {
	local key=$(get_tmux_option "$pipe_pane_key_option" "$default_pipe_pane_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_proper_pipe_pane.sh"
}

setup_pane_screenshot_key_binding() {
	local key=$(get_tmux_option "$pane_screenshot_key_option" "$default_pane_screenshot_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_pane_screenshot.sh"
}

setup_scrollback_dump_key_binding() {
	local key=$(get_tmux_option "$scrollback_dump_key_option" "$default_scrollback_dump_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_scrollback_dump.sh"
}

setup_clear_scrollback_key_binding() {
	local key=$(get_tmux_option "$clear_scrollback_key_option" "$default_clear_scrollback_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_scrollback_clear.sh"
}

main() {
	setup_pipe_pane_key_binding
	setup_pane_screenshot_key_binding
	setup_scrollback_dump_key_binding
	setup_clear_scrollback_key_binding
}
main
