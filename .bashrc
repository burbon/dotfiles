#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

eval $(keychain  --eval --agents ssh --quiet -Q)

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White


########### PROMPT ############
source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

__perlbrew_list() {
  out="$(perlbrew list 2>/dev/null)"
  echo $out | grep \* | cut -c3-
}

__cmd_status() {
  if [[ $? != 0 ]]; then
    #echo [\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200
    echo ZUPA
  else
    echo DUPA
  fi
}

PS1='[\u@\h \W]\$ '

PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'

F_TIME="\[\033[00;36m\]\t\[\033[00;00m\]"
F_NAME="\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;33m\]\h\[\033[00;00m\]"
F_DIR="\[\033[00;36m\]\$CurDir\[\033[00;00m\]"
F_DIR_FULL="\[\033[00;36m\]\w\[\033[00;00m\]"
F_GIT="\[$Red\]\$(__git_ps1 '%s')\[$Color_Off\]"
F_PERLBREW="\$(__perlbrew_list)"
__cmd_status() {
  if [[ $? != 0 ]]; then
    echo "\[$Red\]✗\[$Color_Off\]"
  else
    echo "\[$Green\]✓\[$Color_Off\]"
  fi
}
F_OK="$(__cmd_status)"
F_OK="\$(if [[ \$? != 0 ]]; then echo \"\[$Red\]✗\[$Color_Off\]\"; else echo \"\[$Green\]✓\[$Color_Off\]\"; fi)"

PS1="┌─[$F_OK]─[$F_TIME]─[$F_NAME]─[$F_DIR_FULL]-[$F_GIT]-[$F_PERLBREW]\n└──╼ "
PS2="╾──╼ "

########### END_PROMPT ############

source $HOME/perl5/perlbrew/etc/bashrc
export HISTCONTROL=ignoredups
export EDITOR=vim
export MPD_HOST="wpiszcos@localhost"

export PATH=$HOME/bin:$PATH
