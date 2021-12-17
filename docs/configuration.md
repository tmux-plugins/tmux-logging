# Custom configuration

The default logging path is `$HOME` but can be changed per log type.  

To change the logging paths, add the following lines to your `.tmux.conf` file:  
* For continuous pane logs: `set -g @logging-path "path"`  
* For screen captures: `set -g @screen-capture-path "path"`  
* For complete pane history: `set -g @save-complete-history-path "path"`
