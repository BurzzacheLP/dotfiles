#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

#PS1='[\u@\h \W]\$ '

PS1='[\u@\h]=>(\W)\$ '

snvim () {
    sudo -E nvim "$1"
}


(cat ~/.cache/wal/sequences &)

# Created by `pipx` on 2024-04-04 18:22:26
export PATH="$PATH:/home/lucho/.local/bin"
