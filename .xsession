#	$Id: .xsession,v 1.4 2020/05/18 08:44:39 kevin Exp kevin $

# Call xrdb to set the xterm font and colors.
xrdb ~/.Xresources 

# Launch xterm with the -ls option to call ksh as a login shell and
# execute ~/.profile. --need to look at the sh and ksh manpages and
# re-word this.

# xterm -ls

# Start cwm; launch xterm first.
 xterm &
 cwm

# Start xfce, without xterm.
# startxfce4

