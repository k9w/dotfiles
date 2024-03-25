# $ OpenBSD: dot.profile,v 1.5 2018/02/02 02:29:54 yasuoka Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:$HOME/.local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games

CVSROOT=/cvs

export PATH HOME TERM CVSROOT

# If the ENV parameter is set when an interactive shell starts (or, in
# the case of login shells, after any profiles are processed), its value
# is subjected to parameter, command, arithmetic, and tilde (`~')
# substitution and the resulting file (if any) is read and executed.  In
# order to have an interactive (as opposed to login) shell process a
# startup file, ENV may be set and exported (see below) in
# $HOME/.profile - future interactive shell invocations will process any
# file pointed to by $ENV:

if [ -e ~/.kshrc ]; then
	: ${ENV='~/.kshrc'}
	export ENV

fi

alias srh='ssh -i ~/.ssh/borg_ed25519 -t 3310@usw-s003.rsync.net'

alias mosh='LC_ALL="en_US.UTF-8" mosh'

alias cvsup=~/bin/learn-cvs/cvs-ports-src-xenocara.sh
