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

local user_color=$FG[157]; [ $UID -eq 0 ] && user_color=$FG[160]
local pwd_color=$bold_color$FG[111];
local ps2_color=$FG[196];

local user_prompt=$(echo -e "\xE0\xA5\x90\ ")
PROMPT='%{$bold_color%}%{$user_color%}%n%{$reset_color%}:%{$pwd_color%}${PWD/#$HOME/~} %{$reset_color%}%(!.#.$user_prompt) '
PROMPT2='%{$ps2_color%}⁝ %{$reset_color%}'

RPROMPT='$(git_prompt_info)'

# vi-mode
MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"

# git theming
local git_prompt_guard_color=$reset_color$FG[143];
local git_prompt_branch_color=$reset_color$FG[215];
local git_prompt_untracked_color=$bold_color$FG[160];
local git_prompt_modified_color=$bold_color$FG[190];
local git_prompt_added_color=$bold_color$FG[048];
local git_prompt_stashed_color=$bold_color$FG[147];
local git_prompt_unmerged_color=$bold_color$FG[120];
local git_prompt_upstream_color=$bold_color$FG[039];

ZSH_THEME_GIT_PROMPT_PREFIX="%{$git_prompt_guard_color%}±(%{$git_prompt_branch_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$git_prompt_guard_color%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$git_prompt_untracked_color%}•"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$git_prompt_modified_color%}•"
ZSH_THEME_GIT_PROMPT_ADDED="%{$git_prompt_added_color%}•"
ZSH_THEME_GIT_PROMPT_STASHED="%{$git_prompt_stashed_color%}⚡"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$git_prompt_unmerged_color%}≢"
ZSH_THEME_GIT_PROMPT_UPSTREAM_EQUAL=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_AHEAD="%{$git_prompt_upstream_color%}»"
ZSH_THEME_GIT_PROMPT_UPSTREAM_BEHIND="%{$git_prompt_upstream_color%}«"
ZSH_THEME_GIT_PROMPT_UPSTREAM_DIVERGED="%{$git_prompt_upstream_color%}«»"
