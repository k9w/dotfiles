# 06-03-20

Manjaro pre-installed by Pine; delivered to door 06-03-20

Powered on and ran through onboarding same day UTC time.

Shipped with kernel 5.6.0. Applied 790MB of updates, including kernel
5.6.0-2.

Packages pre-installed (of note):
 - kdeplasma (default dark theme), firefox, libreoffice
 - nano, git, pamac (AUR helper)


Packages added:
 - tmux, rcs (brings ed), vi (not vim), mg
 - chromium, sshfs, print-manager, rsync, borg (backup)

Installed AUR helper is pamac.


<p>
# 06-04

~Successfully logged into Firefox and Chromium, logged into google
accounts, setup password managers, set dark themes. 

Only thing left to configure is encrypted media extensions.

~Successfully added .mg and .nexrc.

~Successfully configured Crista's local account and signed her into
accounts on Firefox and Chromium.

Hopefullyy setting up encrypted media extennsions will work machine-wide.

Building google-chrome...
==> ERROR: google-chrome is not available for the 'aarch64' architecture.

I might not currently be able to use Hulu, Netflix, or Amazon Prime Video 
on the PineBook Pro.

Try this one next:
https://forum.pine64.org/showthread.php?tid=9680

https://www.uex.dk/public/manjaro/arm-unstable/community/aarch64/chromium-docker-4.10.1610.6-2-aarch64.pkg.tar.xz

The guide said it would be a 3GB download in a Docker container. It looks to be downloading a full copy of ChromeOS.


<p>
# 06-09

# pacman -Rsu chromium-docker
checking dependencies...
:: ark optionally requires p7zip: 7Z format support

Packages (7) bridge-utils-1.6-4  containerd-1.3.4-2
docker-1:19.03.9-1  p7zip-16.02-6  runc-1.0.0rc10-2
             xorg-xhost-1.0.8-2  chromium-docker-4.10.1610.6-2

Total Removed Size:  326.16 MiB

Manually removed chromium-armv7 from ~.


<p>
# 08-18

Checked in /etc/sudoers to RCS without changes beyond adding keyword Id.

Discovered kevin was already enabled for sudo with password from the
installer in /etc/sudoders.d/10-installer.
%wheel ALL=(ALL) ALL

Decided to leave sudo with password for kevin.


<p>
# 08-20

The pinebook pro keeps shutting down suddenly when I press the
backspace key or power button quickly, and by accident. This is
annoying when editing and deleting text in a file, becausee it causes
me to lose my place in my work until the system comes back on.

Today I consulted:
https://wiki.archlinux.org/index.php/Power_management

I changed /etc/systemd/logind.conf and checked it into RCS.

Set HandlePowerKey from poweroff to ignore, per logindconf(5).


<p>
# 09-14

Last week I purchased PDFs of Michael W Lucas books SSH Mastery and
Tarsnap Mastery. Today I configured Okular to use dark mode according to:

https://www.reddit.com/r/kde/comments/7ww4ja/changing_okular_colour_scheme

Added ID Keyword to ~/.config/okularrc
cat /usr/share/plasma/desktoptheme/breeze-dark/colors >> ~/.config/okularrc

That did not work. So I reverted the change. I then found the
solultion in the settings > Accessibility > Invert Colors.

cd ~/.config

Since I had not checked in my changes, just the original version, I
checked out the most recent version, the original.
co okularrc

Then lock it in RCS to make it writable.
ci -l okularrc


<p>
# 11-21-20

Installed sshfs.
sftp -i ~/.ssh/borg_ed25519 3310@usw-s003.rsync.net
sshfs 3310@usw-s003.rsync.net:/data2/home/3310 ~/mnt -oIdentityFile=~/.ssh/borg_ed25519,allow_other,default_permissions
fusermount3 -u ~/mnt
fusermount3: option allow_other only allowed if user_allow_other is set in /etc/fuse.conf
sshfs nas:/home/nas ~/nas


<p>
# 01-05-21

Installed print-manager to add Terri-s printer.


<p>
# 01-25

Installed acts-git which depends on tarsnap.
# pamac install acts-git


<p>
# 03-06

Installed borgbackup and rsync.


<p>
# 05-08

Added new ssh keypair unique to this laptop.

$ cd ~/.ssh
$ mv id_ed25519.pub 63.pub
$ mv id_ed25519 63
$ ssh-keygen -t ed25519 -C manjaro-pinebook


<p>
# 06-10

Installed Remmina RDP and VNC client.

# pamac install remmina


<p>
# 06-30

Added ~/.tmux.conf

Change tmux prefix from C-b to backtick `, which is easier to type
twice when the app in tmux needs C-b.


<p>
# 08-05

Renamed this file. Installed Emacs with GUI.

```
$ mv configuration configuration-pinebook.md

# pamac install emacs
```

<p>
# 09-18

Installed Kamoso from 'add/remove software'.

In Emacs, replace the dashes and date with Markdown newline and date
as heading.

```
M-% '--------^q^j' <enter> '<p>^q^j# '
```

<p>
# 10-12

Installed GVim from graphical app 'Add/Remove Software' with no
optional dependencies for language bindings such as Python, Ruby,
Perl, etc. Those can be added later if needed.

vi(1)'s ~/.exrc is read by GVim and gives an error on not recognizing
the vi-specific 'wl=72 for wrapping lines at 72 characters. Vim would
have its own directive for that in ~/.vimrc.

Vim reads .exrc even thought its manpage does not docuument it.

What if populating .vimrc causes vim to not even read .exrc?

Would vi read .nexrc if I reenamed .exrc to that?


<p>
# 10-13

nvi on Arch Linux ARM has no wrap lines option for wl=72. Need to find
an alternative line wrap method.


<p>
# 10-25

The wrapmargin option to nvi does not work either. Removed ~/.exrc so
as to not interfere with GVim.


<p>
# 12-08

Added .gitconfig and .gitignore to ~ without making ~ a dotfiles repo
yet. 

Today I finished maing ~ a dotfiles repo on branch manjaro-pinebook.

