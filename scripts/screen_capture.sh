#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"
source "$CURRENT_DIR/capture_pane_helpers.sh"

main() {
	if supported_tmux_version_ok; then
		capture_pane "Screen capture"
	fi
}
main
