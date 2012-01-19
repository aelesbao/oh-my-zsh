# ZSH Theme emulating the Fish shell's default prompt.

PROMPT='%(!.%{$fg_bold[red]%}.%F{white}%n):%{$fg_bold[blue]%}%d %# %{$reset_color%}'
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
