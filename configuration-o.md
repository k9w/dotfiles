# 05-15-20

installed as 6.7-current

/etc:
/X11/xenodm/Xsetup_0
hostname.iwm0, wsconsctl.conf

/home/kevin:
.Xresources, .kshrc, .profile, .xsession

packages:
chromium, firefox, openbsd-backgrounds, ee, portslist
tarsnapper (wrapper script for tarsnap, which must be installed from
ports first; the tarsnap port maintainer has chosen to not produce a
tarsnap package)
xfce-extras (which brought in subversion, git), xpdf (no dark mode)
rsync, borgbackup

ports:
tarsnap

<p>
# 05-22

 - dark mode (web rendering, not titlebars or menus)
https://mybrowseraddon.com/dark-mode.html
Installed to both Firefox and Chrome
                           
 - dark theme (for toolbars, menus)
Firefox > Settings > Customize > Themes > Dark
https://www.techradar.com/how-to/how-to-enable-dark-mode-for-firefox

Chrome webstore > Just Black

<p>
# 06-23

Need to fix pkg_add-u.sh in /root

 - The opening multi-line quote is broken by the nested command which
uses the single quotes.

 - Need to have the script auto-remove or auto-comment out the @reboot
entry from root's crontab after successful upgrade.


<p>
# 07-14

Created ~/cvsroot repo and set $CVSROOT in .kshrc according to:
https://www-mrsrl.stanford.edu/~brian/cvstutorial

cvs -d ~/cvsroot init

Imported the cvsexample as module cvsexample.d and checked it out.

Imported ~/openbsd-laptop, renamed original to openbsd-laptop.bak.d, and
checked out a working copy as openbsd-laptop (module name).


<p>
# 07-29


Activated doas.conf for wheel members without password and with users
own environment variables.

permot nopass keepenv :wheel


Appended kevin to operator group to allow halt/reboot and mount/umount
within XFCE, but not on commandline without doas.

usermod -G operator kevin


Checked in doas.conf to RCS. Needed to edit revision comment.

doas rcs -m1.1:"initial check-in" /etc/doas.conf


Set doas.conf from Read Write by root and read by group and other, 0644,
to read write only by root 0600.

chmod 0600 /etc/doas.conf


Removed keepenv. RCS already records the user invoking doas ci as the
revision author, rather than genericaly attributing it generally to
root.Passing through the invoking user environment variables is not
needed to achieve that.

Changed doas.conf,v from world readable 0444 to readable only by root
0400.

chmod 0400 /etc/doas.conf,v


Restored group read permission to doas.conf[,v] so that they can be
backed up with sftp rather than requiring ssh from root.

chmod 0640 /etc/doas.conf
chmod 0440 /etc/doas.conf,v

Successfully backed up /etc/doas.conf* to c.k9w.org > openbsd-laptop.


<p>
# 09-13

Yesterday I tried to install tarsnapper from packages. But it failed
to install because it could not find tarshap as a package. It only
exists as a port.

So today I added the ports tree to this system.OB

Added kevin to wsrc group for ports tree.
doas usermod -m wsrc kevin

Logged out (completely from X11) and back in.
cd /usr

The cvs checkout ask kevin did not have permission for anything, not
even after I created the ports directory manually and changed its group
ownership from wheel to wsrc.
doas mkdir ports
doas chgrp wsrc ports

So I executed cvs checkout as root with doas.
doas cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports

That succeeded. Then I added the following commands to update the ports
tree in pkg_add-u.sh after a sysupgrade.
cd /usr/ports
cvs -q up -Pd -A

Installed xpdf. It works but does not support dark mode. Tried to
install okular. But it failed due to some dependencies not found.

Need to install portslist or sqlports package to search the ports tree
with Make.

Tarsnapper and Okular both have some dependencies installed from their
failed package installs.


<p>
# 09-16

Successfully installed tarsnap from ports.
cd /usr/ports/sysutils/tarsnap
doas make install

Tried to install evince to get a dark mode PDF reader, since xpdf does
not support dark mode. It did not work.

Successfully removed dependency packages needed by okular, evince, and
evince-light.
pkg_delete -a


<p>
# 10-15

Track system configuraion changes in a local CVS repository. It should
be as secure as the most sensiive file it tracks. For files such as
/etc/pf.conf, that means only root should run CVS commands for this
system configuration management repo.

Put repository in root of /home. Call it cvs.

Modules are etc, usr, var, and kevin (for /home/kevin).

As root:
cd /home
cvs -d /home/cvs init

cvs -d /home/cvs import -m "" etc kevin start
cvs -d /home/cvs import -m "" kevin kevin start
cvs -d /home/cvs import -m "" usr kevin start
cvs -d /home/cvs import -m "" var kevin start

cd /
cvs -d /home/cvs checkout etc
? etc/rc

cvs -d /home/cvs checkout usr
? usr/src

cvs -d /home/cvs checkout var
? var/log

cd /home
cvs -d /home/cvs checkout kevin
? kevin/.mg

Next task is cvs add the files I want to track.


<p>
# 12-16

Set sndio to recognize a USB headset as alternate device rsnd/1. Sound
playback works. But the microphone does not.

doas rcctl set sndiod flags -f rsnd/0 -F rsnd/1
doas rcctl restart sndiod


<p>
# 12-25-20

Installed portslist.


<p>
# 01-08-21

Removed tarsnapper package. Kept tarsnap installed from ports.

Planned:

Installed ACTS script from GitHub to automate tarsnap from:
https://github.com/alexjurkiewicz/acts

Install it to /usr/local/scripts, to not interfere with pkg_add 
operations.


<p>
# 02-06

Transition this install from RCS to SVN. I do no plan to migrate the RCS
history into SVN.

Setup process to follow is documented in ~/instructions/svn_setup.

Successfully created dotfiles repo. Still need to create conf repo.


<p>
# 02-07

Successfully created conf repo and added all needed files. svn setup
complete.


<p>
# 03-15

Installed rsync.

Tried to install borgbackup but could not due to library dependency
mismatches.  Need to try again after a sysupgrade and pkg_add -u.


<p>
# 04-01

Added /etc/fstab to SVN and added noatime.


<p>
# 04-12

xfce desktop looks for backgrounds in
/usr/local/share/backgrounds/xfce. The package openbsd-backgrounds
puts its many pictures in multiple subfolders of
/usr/local/share/openbsd-backgrounds. 

I want xfce to randomly rotate the wallpaper among all those pictures.
But it does not recurse through subdirectories.

https://gitlab.xfce.org/xfce/xfdesktop/-/issues/50

So I recursively symlinked all the openbsd-backgrounds to the xfce
folder.

doas ln -s \
$(find /usr/local/share/openbsd-backgrounds/ \( -name \*jpg -o \
-name \*JPG -o -name \*jpeg \) -print) \
/usr/local/share/backgrounds/xfce/


<p>
# 05-04

Switched to different ssh keypair per each client PC, or phone.
Deprecated my previous keypair shared across all devices.

Here is the one for this os on this laptop. Will make a separate key
for Fedora on this same laptop.

$ cd ~/.ssh
$ mv id_ed25519.pub 63.pub
$ mv id_ed25519 63
$ ssh-keygen -t ed25519 -C openbsd-thinkpad

<p>
# 07-24

Renamed configuration and ,v to configuration-o.md
```
$ mv configuration configuration-o.md
```

Removed symlinks to three sideways pictures after saving rotated
copies still failed to display correctly.

Pictures at:
/usr/local/share/openbsd-backgrounds/portrait/kirby

Symlinks a:
/usr/local/share/backgrounds/xfce

<p>
# 08-05

Installed GNU Emacs with GTK3 after I reached chapter 20 on Frames in
the Emacs manual. Readme at /usr/local/share/doc/pkg-readmes/emacs

<p>
# 08-08

Installed MELPA package repo alongside default ELPA package repo.

Installed markdown-preview-mode. See instrucitons at:
<https://github.com/ancane/markdown-preview-mode>

markdown-preview-mode-open-browser opens the browser but fails to
connect, I assume because my local OpenBSD httpd is not running and not
listening on port 9000.


<p>
08-21

OpenBSD project deprecated dhclient for the new dhcpleased. In
/etc/hostname.if, dhclient uses dhcp and dhcpleased uses 'inet
autoconf'.
http://undeadly.org/cgi?action=article;sid=20210722072359

/etc/hostname.{em0,iwm0}

Changed 'dhcp' to 'inet autoconf'.


<p>
09-08

Installed vim with gtk3, perl, python3, and ruby.


<p>
09-10

Chromium was saying on each launch that it could not load the profile.
Then the extensions would not load until I clicked on them. So today I
uninstalled Chromium and moved the chromium folders from ~/.cache and
~/.config to ~/.backup.

Re-installing Chromium failed due to dependency package mismatches
since I haven't updated base and packanges in 9 days.

```
$ doas pkg_add chromium
quirks-4.47 signed on 2021-09-10T08:50:44Z
quirks-4.45->4.47: ok
Can't install avahi-libs-0.8p1 because of conflicts (avahi-0.8p0)
Can't install cups-libs-2.3.3.2p1: can't resolve avahi-libs-0.8p1
Can't install gtk+3-cups-3.24.30: can't resolve cups-libs-2.3.3.2p1
chromium-93.0.4577.63p1:libxkbcommon-1.3.0: ok
chromium-93.0.4577.63p1:noto-emoji-20200408: ok
chromium-93.0.4577.63p1:noto-fonts-20171024: ok
Can't install chromium-93.0.4577.63p1: can't resolve cups-libs-2.3.3.2p1,gtk+3-cups-3.24.30
Read shared items: ok
Updating font cache: ok
--- +noto-emoji-20200408 -------------------
You may wish to update your font path for /usr/local/share/fonts/noto
--- +noto-fonts-20171024 -------------------
You may wish to update your font path for /usr/local/share/fonts/noto
--- avahi-libs-0.8p1 -------------------
Can't install avahi-libs-0.8p1: conflicts
Couldn't install avahi-libs-0.8p1 chromium-93.0.4577.63p1
cups-libs-2.3.3.2p1 gtk+3-cups-3.24.30
$
```


<p>
# 09-13

Setup git repo for dotiles in ~ and documented it in
~/instructions/git_setup. Need to set remote repo on github for it.
Nowwhere yet have I specified the name 'dotfiles' for the repo.

I can make a test repo in ~/git-repos and do 'git remote add' to
9.k9w.org before doing a real one to github.


<p>
# 10-15

Upgraded from 7.0-beta to 7.0-release, to minimize upgrades and save
ware and tear on the SSD.

I had removed Chromium a couple months ago to try uninstall and
re-install to fix the sign-in not working, after Google had pulled that
and made it exclusive to Google Chrome. Re-install failed at the time
because my OpenBSD snapshot was a few weeks old. So I left Chromium off
until my next OpenBSD upgrade.

Today I successfully re-installed Chromium and added my extensions and a
theme Dark Theme for Google Chrome.


