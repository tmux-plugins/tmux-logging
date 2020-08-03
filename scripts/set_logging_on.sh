#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"

set_logging_on() {
    if ! is_logging; then
        $CURRENT_DIR/toggle_logging.sh
    fi
}

main() {
    set_logging_on
}
main
