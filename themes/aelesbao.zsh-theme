#!/usr/bin/env zsh
# Theme by Augusto Elesbão (http://github.com/aelesbao)
#
# Inspired on themes:
#   - arthurgeek
#   - nicoulaj

local user_color=$FG[157]; [ $UID -eq 0  ] && user_color=$FG[160]
local pwd_color=$bold_color$FG[111];
local ps2_color=$FG[196];
local time_color=$user_color;

local user_prompt="$"

# generic scm colors
local scm_prompt_guard_color=$reset_color$FG[143];
local scm_prompt_branch_color=$reset_color$FG[215];
local scm_prompt_action_color=$reset_color$FG[214];
local scm_prompt_untracked_color=$bold_color$FG[160];
local scm_prompt_modified_color=$bold_color$FG[190];
local scm_prompt_staged_color=$bold_color$FG[048];
local scm_prompt_stashed_color=$bold_color$FG[147];
local scm_prompt_unmerged_color=$bold_color$FG[120];
local scm_prompt_upstream_color=$bold_color$FG[039];

ZSH_THEME_REPO_NAME_COLOR=$scm_prompt_branch_color;

# git theming
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$scm_prompt_untracked_color%}•"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$scm_prompt_modified_color%}•"
ZSH_THEME_GIT_PROMPT_ADDED="%{$scm_prompt_staged_color%}•"
ZSH_THEME_GIT_PROMPT_DELETED="%{$scm_prompt_staged_color%}×"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$scm_prompt_staged_color%}➜"
ZSH_THEME_GIT_PROMPT_STASHED="%{$scm_prompt_stashed_color%}↯"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$scm_prompt_unmerged_color%}⇄"
ZSH_THEME_GIT_PROMPT_UPSTREAM_EQUAL=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_AHEAD="%{$scm_prompt_upstream_color%}»"
ZSH_THEME_GIT_PROMPT_UPSTREAM_BEHIND="%{$scm_prompt_upstream_color%}«"
ZSH_THEME_GIT_PROMPT_UPSTREAM_DIVERGED="%{$scm_prompt_upstream_color%}«»"

# hg theming
ZSH_THEME_HG_PROMPT_DIRTY="%{$scm_prompt_modified_color%}•"
ZSH_THEME_HG_PROMPT_CLEAN=""

# svn theming
ZSH_THEME_SVN_PROMPT_DIRTY="%{$scm_prompt_modified_color%}•"
ZSH_THEME_SVN_PROMPT_CLEAN=""

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*'     enable git hg bzr svn

zstyle ':vcs_info:*:*'   check-for-changes true  # can be slow on big repos.
zstyle ':vcs_info:git:*' check-for-changes false # for git we use oh-my-zsh implementation.

zstyle ':vcs_info:*:*' stagedstr   "%{$scm_prompt_staged_color%}•"
zstyle ':vcs_info:*:*' unstagedstr "%{$scm_prompt_modified_color%}•"

zstyle ':vcs_info:*:*' formats       "%S" "%{$scm_prompt_guard_color%}%s(%{$scm_prompt_branch_color%}%b%m%u%c%{$scm_prompt_guard_color%})%{$reset_color%}"
zstyle ':vcs_info:*:*' actionformats "%S" "%{$scm_prompt_guard_color%}%s(%{$scm_prompt_branch_color%}%b%m%u%c%{$scm_prompt_action_color%}:%a%{$scm_prompt_guard_color%})%{$reset_color%}"

zstyle ':vcs_info:(svn|bzr):*' branchformat "%b%{$scm_prompt_action_color%}:%r"

zstyle ':vcs_info:git+set-message:*' hooks git-prompt-info
zstyle ':vcs_info:svn+set-message:*' hooks svn-prompt-info
zstyle ':vcs_info:hg+set-message:*'  hooks hg-prompt-info

zstyle ':vcs_info:*+*:*' debug false

+vi-git-prompt-info() {
  hook_com[vcs]="±"
  hook_com[staged]=""
  hook_com[unstaged]=""
  hook_com[misc]="$(parse_git_dirty)$(git_prompt_status)$(git_stash_info)$(git_upstream_info)"
}

+vi-svn-prompt-info() {
  hook_com[vcs]="⚡"
}

+vi-hg-prompt-info() {
  hook_com[vcs]="☿"
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

# prompts
PROMPT='%{$pwd_color%}${PWD/#$HOME/~} %{$user_color%}%(!.#.$user_prompt)%{$reset_color%} '
PROMPT2='%{$ps2_color%}⁝ %{$reset_color%}'

RPROMPT='${vcs_info_msg_1_} %{$time_color%}[%D{%T}]%{$reset_color%}'

# vi-mode
MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
