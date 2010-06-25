########### PROMPT ############
PS1='[\u@\h \W]\$ '

PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'

F_TIME="\[\033[00;36m\]\t\[\033[00;00m\]"
F_NAME="\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;33m\]\h\[\033[00;00m\]"
F_DIR="\[\033[00;36m\]\$CurDir\[\033[00;00m\]"
F_GIT='$(__git_ps1 " (%s)")'

PS1="┌─[$F_TIME]─[$F_NAME]─[$F_DIR]$F_GIT\n└─]\$ "

########### END_PROMPT ############

export HISTCONTROL=ignoredups
export EDITOR=vim
export MPD_HOST="passwd@host"

. $HOME/.bashrc
