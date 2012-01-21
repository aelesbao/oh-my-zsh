# ZSH theme inspired by arthurgeek theme.

# Add the branch name and the working tree status information
git_prompt_info () {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_status)$(git_stash_info)$(git_upstream_info)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# show the differences between HEAD and its upstream
git_upstream_info() {
  # find how many commits we are ahead/behind our upstream
  COUNT=$(git rev-list --count --left-right @{upstream}...HEAD 2> /dev/null)
  STATUS=""
  case "$COUNT" in
    "") # no upstream
      STATUS="" ;;
    "0	0") # equal to upstream
      STATUS="$ZSH_THEME_GIT_PROMPT_UPSTREAM_EQUAL" ;;
    "0	"*) # ahead of upstream
      STATUS="$ZSH_THEME_GIT_PROMPT_UPSTREAM_AHEAD" ;;
    *"	0") # behind upstream
      STATUS="$ZSH_THEME_GIT_PROMPT_UPSTREAM_BEHIND" ;;
    *) # diverged from upstream
      STATUS="$ZSH_THEME_GIT_PROMPT_UPSTREAM_DIVERGED" ;;
  esac
  echo $STATUS
}

# show stash info
git_stash_info() {
  STATUS=""
  git rev-parse --verify refs/stash >/dev/null 2>&1 && STATUS="$ZSH_THEME_GIT_PROMPT_STASHED"
  echo $STATUS
}

local user_color='white'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%{$fg_bold[$user_color]%}%n%{$reset_color%}:%{$fg_bold[blue]%}${PWD/#$HOME/~} %{$reset_color%}%(!.#.૱) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

RPROMPT='$(git_prompt_info)'

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}[%{$fg_no_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_no_bold[blue]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}•"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}•"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}•"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[cyan]%}⚡"
ZSH_THEME_GIT_PROMPT_UPSTREAM_EQUAL=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_AHEAD="%{$fg_bold[cyan]%}→"
ZSH_THEME_GIT_PROMPT_UPSTREAM_BEHIND="%{$fg_bold[cyan]%}←"
ZSH_THEME_GIT_PROMPT_UPSTREAM_DIVERGED="%{$fg_bold[cyan]%}↔"
