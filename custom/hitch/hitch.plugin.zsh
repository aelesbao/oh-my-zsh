# hitch: tool to edit authors when in pair programming
if [ -n "`command -v hitch`" ]; then
  hitch() {
    command hitch "$@"
    if [[ -s "$HOME/.hitch_export_authors"  ]] ; then source "$HOME/.hitch_export_authors" ; fi
  }
  alias unhitch='hitch -u'
  # Uncomment to persist pair info between terminal instances
  hitch
fi
