: '

Shell startup file executed every time /bin/ksh is invoked.

'

echo .kshrc
if [ SSH_AUTH_SOCK != $(find /tmp -name agent*) ]; then
	export SSH_AUTH_SOCK=$(find /tmp -name agent*)
fi

# EDITOR=/usr/bin/mg
# export EDITOR 

