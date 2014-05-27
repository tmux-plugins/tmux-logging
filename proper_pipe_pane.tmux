#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/scripts/shared.sh

default_pipe_pane_key="P"
default_pane_screenshot_key="M-p"   # Alt-p

setup_pipe_pane_key_binding() {
	local pipe_pane_key=$(get_tmux_option "@ppp_pipe_pane_key" "$default_pipe_pane_key")
	tmux bind-key "$pipe_pane_key" run-shell "$CURRENT_DIR/scripts/tmux_proper_pipe_pane.sh"
}

setup_pane_screenshot_key_binding() {
	local pane_screenshot_key=$(get_tmux_option "@ppp_pane_screenshot_key" "$default_pane_screenshot_key")
	tmux bind-key "$pane_screenshot_key" run-shell "$CURRENT_DIR/scripts/tmux_pane_screenshot.sh"
}

main() {
	setup_pipe_pane_key_binding
	setup_pane_screenshot_key_binding
}
main
