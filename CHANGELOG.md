# Changelog

### master

### v2.1.0, 2015-03-18
- `capture-pane` gets a `-J` flag. It joins wrapped lines and preserves trailing
  spaces at each line's end.
- when capturing whole history, do not guess its size, but get it from
  `#{history_limit}` format flag

### v2.0.0, 2015-03-14
- update readme
- extract default keys and key options to `variables.sh` file
- require tmux version 1.9 or greater to use the plugin
- change all internal variable names (BREAKING CHANGE!)
- change internal script names
- lot of internal refactoring

### v1.0.0, 2014-11-09
- improve `capture-pane`. It is now piped directly to the target file.

### v0.0.2, 2014-08-26
- add other plugins list to the README
- update readme to reflect github organization change
- add a 'clear pane history' key binding

### v0.0.1, 2014-06-02

- first working release
