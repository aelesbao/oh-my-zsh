# Aliases
alias resource="source ~/.zshrc"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias all_users="cut -d: -f1 < /etc/passwd | sort | xargs echo"
alias all_groups="cut -d: -f1 < /etc/group | sort | xargs echo"

alias psc="ps xawf -eo pid,user,cgroup,args"
alias del="mv -t ~/.local/share/Trash/files"

alias pjson="python -m json.tool"

alias etckeeper="sudo etckeeper"
