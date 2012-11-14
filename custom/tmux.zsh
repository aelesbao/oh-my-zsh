# Enable tmux on any tty
if [[ $TERM != screen* ]] && [ -x /usr/bin/tmux ]; then
  vico="$(tty | grep -oE ....$)"
  case "$vico" in
    tty*) exec /usr/bin/tmux;;
  esac
fi

