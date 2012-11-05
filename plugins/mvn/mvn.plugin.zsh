bash_source() {
  alias shopt=':'
  alias _expand=_bash_expand
  alias _complete=_bash_comp
  emulate -L bash
  setopt kshglob noshglob braceexpand

  source "$@"
}

if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i

  bash_source "${0%/*}/bash_completion.bash"
fi
