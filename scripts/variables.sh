SUPPORTED_VERSION="1.9"

# Key binding options and defaults

logging_key_option="@logging-key"
default_logging_key="P" # Shift-p

pane_screen_capture_key_option="@screen-capture-key"
default_pane_screen_capture_key="M-p" # Alt-p

save_complete_history_key_option="@save-complete-history-key"
default_save_complete_history_key="M-P" # Alt-Shift-p

clear_history_key_option="@clear-history-key"
default_clear_history_key="M-c" # Alt-c

# Logging options

logging_path_option="@logging-path"
default_logging_path="$HOME"

logging_filename_option="@logging-filename"
default_logging_filename="tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log"
