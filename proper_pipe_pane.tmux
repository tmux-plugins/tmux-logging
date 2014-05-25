#!/usr/bin/env bash

# This plugin extends basic tmux pipe-pane (a.k.a. logging) functionality
# nicely described here: http://unix.stackexchange.com/a/10259
# Improvements:
# 1. uses `ansifilter` (if it's installed) to clean out unreadable ANSI codes
#	from the pipe-pane log
# 2. *one* key is used to toggle tmux `pipe-pane`. That is usually possible
#	when `pipe-pane -o` is used, but then you can't get a descriptive log
#	message. Basically, you don't know if logging started or it just ended.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/scripts/shared.sh

default_ppp_key="P"

setup_key_binding() {
	local ppp_key=$(get_tmux_option "@ppp_key" "$default_ppp_key")
	tmux bind-key "$ppp_key" run-shell "$CURRENT_DIR/scripts/tmux_proper_pipe_pane.sh"
}

main() {
	setup_key_binding
}
main
