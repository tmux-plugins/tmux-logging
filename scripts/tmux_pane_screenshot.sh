#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_screenshot_path="$HOME"
default_screenshot_name="tmux-screenshot-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log"

source $CURRENT_DIR/shared.sh

get_screenshot_path() {
	get_tmux_option "@ppp_screenshot_path" "$default_screenshot_path"
}

# `tmux save-buffer` command does not perform interpolation, so we're doing it
# "manually" with `display-message`
get_screenshot_name() {
	local name_template=$(get_tmux_option "@ppp_screenshot_name" "$default_screenshot_name")
	tmux display-message -p "$name_template"
}

pane_screenshot() {
	local screenshot_path=$(get_screenshot_path)
	local screenshot_name=$(get_screenshot_name)
	tmux capture-pane
	tmux save-buffer "$screenshot_path/$screenshot_name"
	tmux delete-buffer
	display_message "Pane screenshot saved to $screenshot_path/$screenshot_name"
}

main() {
	pane_screenshot
}
main
