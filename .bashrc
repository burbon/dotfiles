#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto' 
PS1='[\u@\h \W]\$ '

eval $(keychain --eval --agents ssh --quiet -Q)
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

export EDITOR=vim

source $HOME/perl5/perlbrew/etc/bashrc
export HISTCONTROL=ignoredups
export MPD_HOST="wpiszcos@localhost"

export PATH=$HOME/bin:$PATH

source $HOME/.bash_prompt
