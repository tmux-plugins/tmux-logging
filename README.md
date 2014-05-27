# Tmux Logging

Features:

1. Enables logging of all output in the current pane<br/>
   After you start logging, everything that's typed and all the output will be
   saved to a file. Convenient for keeping track of your work.
2. Enables "screen capture" of the current pane<br/>
   All the text visible in the current pane is saved to a file. Like a
   screenshot, but textual.
3. Enables saving a complete history of the current pane<br/>
   Everything that has been typed and all the output since the creation of the
   current pane can be saved to a file.

### 1. Logging

Key binding: `prefix + shift + p`<br/>
File path: `$HOME` (user home dir)<br/>
File name template:

    tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log

Toggles (start/stop) logging in the current pane.

This feature improves the default `pipe-pane` logging mechanism by stripping
ANSI codes. This is how the plain `pipe-pane` log output looks like if you're
using terminal with coloring:

![garbled log output](/screenshots/garbled_log_output.png)

Garbled characters are called ANSI codes. They enable colors in terminal, but
are just making 'noise' in the textual log output.

A user will probably want to filter ANSI codes out of the log. Here's the same
log as above when this plugin is used:

![proper log output](/screenshots/proper_log_output.png)

### 2. "Screen capture"

Key binding: `prefix + alt + p`<br/>
File path: `$HOME` (user home dir)<br/>
File name template:

    tmux-screen-capture-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log

Visible text in the current pane is saved to a file. Equivalent of a "texual
screenshot".

### 3. Save complete history

Key binding: `prefix + alt + shift + p`<br/>
File path: `$HOME` (user home dir)<br/>
File name template:

    tmux-history-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log

Saves complete pane history to a file. Convenient if you retroactively remember
you need to log/save all the work.

**NOTE**: this functionality depends on the value of `history-limit` - it
determines the number of lines Tmux keeps in the scrollback buffer. Everything
Tmux kept will also be saved to a file.

With modern computers it is ok to set this option to a high number:

    # in .tmux.conf
    set -g history-limit 50000

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "       \
      bruno-/tpm                \
      bruno-/tmux_logging       \
    "

Hit `prefix + I` to fetch the plugin and source it.

You should now have all `tmux_logging` key bindings defined.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_logging ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/logging.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now have all `tmux_logging` key bindings defined.

### Installing `ansifilter` (recommended for OSX users)

[ansifilter](http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php)
is a program specialized for removing (or working with) ANSI codes.

If you're on OSX, it is recommened to install `ansifilter`:
`$ brew install ansifilter`

It helps with removing ANSI codes from the log. If `ansifilter` is not present,
ANSI codes are removed with `sed`.

### License

[MIT](LICENSE.md)
