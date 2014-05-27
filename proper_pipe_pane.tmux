#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/scripts/shared.sh

default_pipe_pane_key="P"			# Shift-p
default_pane_screenshot_key="M-p"   # Alt-p
default_scrollback_dump_key="M-P"   # Alt-Shift-p

setup_pipe_pane_key_binding() {
	local key=$(get_tmux_option "@pipe_pane_key" "$default_pipe_pane_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_proper_pipe_pane.sh"
}

setup_pane_screenshot_key_binding() {
	local key=$(get_tmux_option "@pane_screenshot_key" "$default_pane_screenshot_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_pane_screenshot.sh"
}

setup_scrollback_dump_key_binding() {
	local key=$(get_tmux_option "@scrollback_dump_key" "$default_scrollback_dump_key")
	tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/tmux_scrollback_dump.sh"
}

main() {
	setup_pipe_pane_key_binding
	setup_pane_screenshot_key_binding
	setup_scrollback_dump_key_binding
}
main
