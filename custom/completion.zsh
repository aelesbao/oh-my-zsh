# Enable remembering of recent directories
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-max 10
zstyle ':completion:*:*:cdr:*:*' menu selection

# cd does not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Use a cache in order to proxy the list of results
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Asserts that directory exists
[ -d ~/.zsh/cache ] || mkdir -p ~/.zsh/cache

# TAB completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Force update of executables for autocomplete
zstyle ":completion:*:commands" rehash 1

# Ignore completion functions for commands you don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'
