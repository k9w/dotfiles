#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export SSH_AUTH_SOCK=$(find /tmp 2> /dev/null | grep agent)
export EDITOR=vim

alias vi=vim
