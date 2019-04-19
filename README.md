# Tmux Logging

Features:

1. Logging of all output in the current pane<br/>
   After you start logging, everything that's typed and all the output will be
   saved to a file. Convenient for keeping track of your work.
2. Current pane "Screen Capture"<br/>
   All the text visible in the current pane is saved to a file. Like a
   screenshot, but textual.
3. Save a complete history of current pane<br/>
   Everything that has been typed and all the output since the creation of the
   current pane can be saved to a file.
4. Clear pane history with `prefix + alt + c`

Tested and working on Linux, OSX and Cygwin.

### 1. Logging

Toggle (start/stop) logging in the current pane.

* Key binding: `prefix + shift + p`
* File name format: `tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
* File path: `$HOME` (user home dir)
  * Example file: `~/tmux-my-session-0-1-20140527T165614.log`

### 2. "Screen Capture"

Save visible text, in the current pane. Equivalent of a "textual screenshot".

* Key binding: `prefix + alt + p`
* File name format: `tmux-screen-capture-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
* File path: `$HOME` (user home dir)
  * Example file: `tmux-screen-capture-my-session-0-1-20140527T165614.log`

### 3. Save complete history

Save complete pane history to a file. Convenient if you retroactively remember
you need to log/save all the work.

* Key binding: `prefix + alt + shift + p`
* File name format: `tmux-history-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
* File path: `$HOME` (user home dir)
  * Example file: `tmux-history-my-session-0-1-20140527T165614.log`

**NOTE**: this functionality depends on the value of `history-limit` - the number
of lines Tmux keeps in the scrollback buffer. Only what Tmux kept will also be saved,
to a file.

Use `set -g history-limit 50000` in .tmux.conf, with modern computers
it is ok to set this option to a high number.

### 4. Clear pane history

Key binding: `prefix + alt + c`

This is just a convenience key binding.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-logging'

Hit `prefix + I` to fetch the plugin and source it.

You should now have all `tmux-logging` key bindings defined.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-logging ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/logging.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now have all `tmux-logging` key bindings defined.

### Installing `ansifilter` (recommended for OSX users)

If you're on OSX, it is recommeneded to install `ansifilter`:
`$ brew install ansifilter`

[ansifilter](http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php)
is a program specialized for removing (or working with) ANSI codes.

It helps with removing ANSI codes from the log. If `ansifilter` is not present,
ANSI codes are removed with `sed`.

This feature improves the default `pipe-pane` logging mechanism by stripping
ANSI codes. This is how the plain `pipe-pane` log output looks like if you're
using terminal with coloring:

![garbled log output](/screenshots/garbled_log_output.png)

Garbled characters are called ANSI codes. They enable colors in terminal, but
are just making 'noise' in the textual log output.

A user will probably want to filter ANSI codes out of the log. Here's the same
log as above when this plugin is used:

![proper log output](/screenshots/proper_log_output.png)

### Other plugins

You might also find these useful:

- [resurrect](https://github.com/tmux-plugins/tmux-resurrect) - restore tmux
  environment after system restart
- [pain control](https://github.com/tmux-plugins/tmux-pain-control) - useful standard
  bindings for controlling panes
- [sessionist](https://github.com/tmux-plugins/tmux-sessionist) - lightweight
  tmux utils for switching and creating sessions

### License

[MIT](LICENSE.md)
