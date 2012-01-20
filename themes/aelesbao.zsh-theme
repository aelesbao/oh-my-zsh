# ZSH Theme created by Augusto Elesbão.

local user_color='white'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%{$fg_bold[$user_color]%}%n%{$reset_color%}:%{$fg_bold[blue]%}${PWD/#$HOME/~} %{$reset_color%}%# '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

RPROMPT='$(git_prompt_info)'

local git_prompt_color="%{$reset_color%}%{$fg[green]%}";
ZSH_THEME_GIT_PROMPT_PREFIX="%{$git_prompt_color%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="$(git_prompt_status)$(git_prompt_ahead)%{$git_prompt_color%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}*"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%}>>"
