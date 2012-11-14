# No beeps
setopt NO_BEEP

setopt AUTO_PUSHD # Makes cd=pushd
setopt AUTO_CD    # Automagically go to a directory, eg type $/etc and hit enter, zsh will chage to /etc

# Enable command line comments
setopt INTERACTIVE_COMMENTS

# History options
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

setopt HIST_REDUCE_BLANKS # Trim multiple insgnificant blanks
setopt HIST_IGNORE_DUPS   # Remove duplicate of previous line
