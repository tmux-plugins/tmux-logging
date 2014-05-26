# Tmux Proper Pipe Pane

Tmux enables easy command logging with `pipe-pane`, but it has some downsides.

This plugin improves the vanilla Tmux `pipe-pane` functionality.

### About

This plugin brings the following improvements to the Tmux logging
functionality:

**1. removes ANSI codes from the log**

This is how the plain `pipe-pane` log output looks like if you're using
terminal with coloring:

![garbled log output](/screenshots/garbled_log_output.png)

Garbled characters are called ANSI codes. They enable colors in terminal, but
are just making 'noise' in the textual log output.

`tmux_ppp` filters ANSI codes out of the log, which makes it nicely readable.
Same log as above when using `tmux_ppp`:

![tmux_ppp log output](/screenshots/tmux_ppp_log_output.png)

**2. single key binding toggles logging start/stop**

[This post on stackexchange](http://unix.stackexchange.com/a/10259) describes
how to setup key-bindings for logging with `pipe-pane`. There are 2
possiblities:
- you can setup a single key binding that toggles logging, but then you don't
  know if the toggle key started or stopped the logging. You just get the
  message logging `is toggled`.
- in order to properly setup messages for `Starting` and `Ending` logging, 2
  key bindings have to be used. With so many Tmux key bindings, you might
  easily forget which key starts and which one ends logging and that'
  inconvenient.

`tmux_ppp` solves above inconveniences by enabling:
- a single key binding that toggles `pipe-pane` logging
- proper notifications, so it's clear whether the logging was started or
  stopped when key was pressed.

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "   \
      bruno-/tpm            \
      bruno-/tmux_ppp       \
    "

Hit `prefix + I` to fetch the plugin and source it.

You should now have `tmux_ppp` binding defined.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_ppp ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/proper_pipe_pane.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now have `tmux_ppp` binding defined.

### Installing `ansifilter` (recommended for OSX users)

[ansifilter](http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php)
is a program specialized for removing (or working with) ANSI codes.

If you're on OSX, it is recommened to install `ansifilter`:
`$ brew install ansifilter`

If you're on Linux, `tmux_ppp` removes ANSI codes with `sed` regexes. This
should work fine, but please [open an issue](/issues) if you find any problems.

### Usage

This plugin defines `prefix + P` key binding (note, that's uppercase `P`).

Press `prefix + P` to start logging. Message is show with the path to log file:

    Started logging to /Users/bruno/tmux-ppp-0-1-20140526T141437.log

To end logging, also press `prefix + P`. You'll get a notification:

    Ended logging to /Users/bruno/tmux-ppp-0-1-20140526T141608.log

### Credits

Thanks to Chris Johnsen for providing
[this answer on stackexchange](http://unix.stackexchange.com/a/10259).
`tmux_ppp` is based on insights from that post.

### License

[MIT](LICENSE.md)
