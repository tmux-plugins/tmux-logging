#!/usr/bin/env bash

# path to log file - global variable
FILE="$1"
# LOG FILTER
LOGGING_FILTER="$2"

ansifilter_installed() {
	type ansifilter >/dev/null 2>&1 || return 1
}

system_osx() {
	[ $(uname) == "Darwin" ]
}

pipe_pane_ansifilter() {
	tmux pipe-pane "exec cat - | ansifilter >> $FILE"
}

pipe_pane_sed_osx() {
	# Warning, very complex regex ahead.
	# Some characters below might not be visible from github web view.
	local ansi_codes_osx="(\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]||]0;[^]+|[[:space:]]+$)"
	tmux pipe-pane "exec cat - | sed -E \"s/$ansi_codes_osx//g\" >> $FILE"
}

pipe_pane_sed() {
	local ansi_codes="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]|)"
	tmux pipe-pane "exec cat - | sed -r 's/$ansi_codes//g' >> $FILE"
}

pipe_pane_no_filter() {
	tmux pipe-pane "exec cat >> $FILE"
}

start_pipe_pane() {
  case "$LOGGING_FILTER" in
    auto)
      if ansifilter_installed; then
        pipe_pane_ansifilter
      elif system_osx; then
        # OSX uses sed '-E' flag and a slightly different regex
        pipe_pane_sed_osx
      else
        pipe_pane_sed
      fi
      ;;
    ansifilter)
      pipe_pane_ansifilter
      ;;
    sed_osx)
      pipe_pane_sed_osx
      ;;
    sed)
      pipe_pane_sed
      ;;
    *)
      pipe_pane_no_filter
  esac
}

main() {
	start_pipe_pane
}
main
