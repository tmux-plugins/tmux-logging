#!/usr/bin/env bash

# path to log file
file=$1

ansifilter_installed() {
	type ansifilter >/dev/null 2>&1 || return 1
}

system_osx() {
	[ $(uname) == "Darwin" ]
}

pipe_pane_ansifilter() {
	local file=$1
	tmux pipe-pane "exec cat - | ansifilter >> $file"
}

pipe_pane_sed_osx() {
	local file=$1
	# Warning, very complex regex ahead.
	# Some characters below might not be visible from github web view.
	local ansi_codes_osx="(\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]||]0;[^]+|[[:space:]]+$)"
	tmux pipe-pane "exec cat - | sed -E \"s/$ansi_codes_osx//g\" >> $file"
}

pipe_pane_sed() {
	local file=$1
	local ansi_codes="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]|)"
	tmux pipe-pane "exec cat - | sed -r 's/$ansi_codes//g' >> $file"
}

start_pipe_pane() {
	local file=$1
	if ansifilter_installed; then
		pipe_pane_ansifilter "$file"
	elif system_osx; then
		# OSX uses sed '-E' flag and a slightly different regex
		pipe_pane_sed_osx "$file"
	else
		pipe_pane_sed "$file"
	fi
}

main() {
	local file=$1
	start_pipe_pane "$file"
}
main "$file"
