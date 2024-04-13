#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\033[1;32m\][\u@\h \W]\$\[\033[0m\] '
set -o vi

FD="find"
if [[ $(command -v fd) != "" ]]; then
    FD="fd"
fi

RG="grip"
if [[ $(command -v rg) != "" ]]; then
    RG="rg"
fi

if [[ -f /usr/share/kbd/consolefonts/ter-118b.psf.gz && -z $DISPLAY ]]; then
    setfont ter-118b
fi

