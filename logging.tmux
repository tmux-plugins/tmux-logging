#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/shared.sh"


main() {
	tmux bind-key -N "Begin logging current pane" "$logging_key" run-shell "$CURRENT_DIR/scripts/toggle_logging.sh"
	tmux bind-key -N "Pane screenshot" "$pane_screen_capture_key" run-shell "$CURRENT_DIR/scripts/screen_capture.sh"
	tmux bind-key -N "Save pane complete history" "$save_complete_history_key" run-shell "$CURRENT_DIR/scripts/save_complete_history.sh"
	tmux bind-key -N "Clear pane history" "$clear_history_key" run-shell "$CURRENT_DIR/scripts/clear_history.sh"
}

main
