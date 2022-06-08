: '

Shell startup file executed every time $ENV is evaluated, if .profile
sets $ENV to ~/.kshrc. It is run each time an interactive shell is
started.

echo .kshrc
if [ SSH_AUTH_SOCK != $(find /tmp -name agent*) ]; then
	export SSH_AUTH_SOCK=$(find /tmp -name agent*)
fi

'

# EDITOR=/usr/bin/mg
# export EDITOR 

