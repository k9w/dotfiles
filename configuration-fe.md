# 02-13-2021

installed after FreeBSD GEOM failed integrity check

Plasma settings:
 - Breeze Dark, Tap-to-Click, Two-finger Scrolling.

Change hostname from localhost.localdomain to f.

```
# hostnamectl set-hostname f
```

Tools of choice already installed:
 - tmux, ed, rsync
 - vim-minimal to /usr/bin/vi

Packages added:
 - mg, nvi, git, rclone, rdiff-backup, emacs, vim-enhanced (for
vimtutor), vim-x11 (for GVim)

Symlink vim to /usr/bin/vi, and vi to /usr/local/bin/nvi.  Put
symlinks in ~/bin, since the default path finds that before /usr/*.

```
$ pwd
/home/kevin
$ mkdir bin && cd bin
$ ln -s /usr/bin/vi ./vim
$ ln -s /usr/bin/nvi ./vi
```

Install rclone and rdiff-backup.

```
# dnf install rclone rdiff-backup
dnf upgrade --refresh
dnf install dnf-plugin-system-upgrade
dnf system-upgrade download --releasever=34 -y
dnf system-upgrade reboot
```


<p>
# 05-06

Today I rotated my shared key, renamed it to 63, and generated a new
keypair specific to this os install and laptop.

```
cd ~/.ssh
mv id_ed25519.pub 63.pub
mv id_ed25519 63
ssh-keygen -t ed25519 -C fedora-thinkpad
```


<p>
# 06-11

Renamed this file from:
configuration

To:
configuration-fe.md

Need to rewrite it in Markdown.

Installed Remmina from Discover.


<p>
# 09-05

Vim-minimal was installed.

Installed Emacs and Vim-X11 from Discover. This did not install
vimtutor. I added vim-enhanced with DNF and then it worked.

Discover had Chrome, but no button to install it. I used the following
instructions to add the repo.

Added repo for non-Fedora software, including Chrome.
<https://docs.fedoraproject.org/en-US/quick-docs/installing-chromium-or-google-chrome-browsers>

```
# dnf install fedora-workstation-repositories
# dnf config-manager --set-enabled google-chrome
```

Then in Discover, the Install button appeared and I installed Chrome.

----

Gvim > Edit > Color Scheme > Industry, looks good. Need to set menu
bar and tool bar to dark or remove them.


<p>
# 10-24

Upgraded to Fedora 35 Beta. First update and reboot as normal to ensure
all Fedora 34 updates have been applied before attempting the upgrade
to 35.

Then, if the dnf-plugin-system-upgrade is already installed from the
last upgrade from 33 to 34, proceed to the next step.

Do a dnf upgrade, but refresh the gpg keys, allowing a new version to
be detected.

```
# dnf upgrade --refresh
```

Download the new release version, with -y to auto-answer 'yes' to any
prompts.

```
# dnf system-upgrade download --releasever=35 -y
```

Remove un-needed packages. You could do this later after the upgrade
instead if you want.

```
# dnf autoremove
```

Apply the new release upgrade and reboot into it.

```
# dnf system-upgrade reboot
```

The upgrade succeeded. But applying the update in the grub boot
environment was very slow, possibly indicating a SSD failure. I've
observed this on OpenBSD on another SSD on the same motherboard. This
could mean it's not just a specific SSD that's the problem. But it's
working for now.

After booting into Fedora 35, 'dnf autoremove' found more packages to remove.

I also installed and ran rpmconf to apply the the upgraded
configuration files which had been saved as .rpmnew or whatever.

```
# dnf install rpmconf
# rpmconf -a
```

That completed successfully.


<p>
# 10-30

After the upgrade, Plasma had no sound. The volume icon showed muted
and had the error message: 'No output or input devices found'.

https://www.reddit.com/r/Fedora/comments/q57gkk/no_audio_device_after_upgrading_to_fedora_35
muety11's comment from Oct 13

This has worked for me.

```
sudo dnf swap wireplumber pipewire-media-session
systemctl --user restart pipewire-media-session
```

It did not work for me because the pipewire-media-session.service unit
file was not found. So I reverted it.


<p>
# 10-31

Install Discord desktop app as an RPM package.

<https://www.linuxcapable.com/how-to-install-discord-on-fedora-34-35>
<https://rpmfusion.org/Configuration>

```
# dnf install dnf-plugins-core -y
```

Was already installed. Next, add the RPM free and non-free repos. They might already be added too.

```
# dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-35.noarch.rpm
# dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-35.noarch.rpm
```

Refresh the repos and search for Discord.

```
# dnf update --refresh
# dnf search discord
```

Then add the repo for Visual Studio Code and install it.

<https://code.visualstudio.com/docs/setup/linux>
<https://computingforgeeks.com/install-visual-studio-code-on-fedora>

Note: This version might lag behind the other distributing channels
Microsoft uses due to the manual key signing per release.

Import the signing key.

```
# rpm --import https://packages.microsoft.com/keys/microsoft.asc
```

Make a new repo file in /etc/yum.repos.d called 'vscode.repo'.

```
# mg /etc/yum.repos.d/vscode.repo
```

Insert the following text:

```
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
```

Then update the repos, search for and install vscode.

```
# dnf update --refresh
$ dnf search code
```

That returns too many results. Search instead for 'refined' which
appears in the package description of VS Code.

```
$ dnf search redefined
```

The three versions I see are:
 - code	  	        - Stable, current release
 - code-exploration	- Old
 - code-insiders	- Future Release

```
# dnf install code
```

<p>
# 11-30


Switch notation to present tense, per git commit guidelines.

Install npm, which brings nodejs and openssl.

Need to test per the Epicodus instructions.


<p>
# 12-05

To change sudo to not require a password, I comment the first wheel
line below in /etc/sudoers and uncommented the second.

```
## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL

## Same thing without a password
# %wheel        ALL=(ALL)       NOPASSWD: ALL
```

Install dotnet and dotnet-script per Epicodus pre-work assignment.

```
# dnf install dotnet
$ dotnet tool install -g dotnet-script
```

Add ~/.dotnet/tools to path in ~/.bash_profile.

```
# Add .NET Core SDK tools
export PATH="$PATH:/home/kevin/.dotnet/tools"
```







<p>
# 12-13


Determine how ssh-agent is started and SSH_AUTH_SOCK is not set.

```
$ grep -Ri ssh-agent /etc 2> /dev/null
$ grep -Ri ssh_auth_sock /etc 2> /dev/null
$ grep -Ri xdg_runtime_dir /etc 2> /dev/null
```

find /run 2> /dev/null | grep ssh | grep socket


<p>
# 12-21

Found post in archlinux subreddit for environment variables in wayland.

```
$ mkdir ~/.config/environment.d
$ echo SSH_AUTH_SOCK=/run/user/1000/ssh-agnet.socket
```

It did not work. ssh_auth_sock is still not set.


Instead I exported ssh_auth_sock to the path of the existing agent:
/run/user/1000/ssh-agent.socket

That works in the terminal and in eshell in emacs. Need more testing.


<p>
# 01-04-2022


So far I've used SSH Keys to push to my self-hosted git server at
r.k9w.org. That requires setting the remote in the SSH format. Git
also offers the HTTP method, which Github defauts to and which
Epicodus assumes.

Github does not allow password authentication on the command line but
does support a Personal Access Token (PAT), an easily revokable
password with custom permissions and by default expires after 30 days.

Here is how to setup and use it in Linux.

Create the token.
<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token>


Here's how to manually paste your token in the password field duirng
'git push'.

Support for password authentication was removed Github Fixed using Token (August 13, 2021) - Linux
<https://www.youtube.com/watch?v=ytSoabxSQ6E>


Store it in Linux with the Github CLI.
<https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git>


Alternatively storing it as plain text in ~/.git-credentials did not
even work properly.

Storing Github Personal Access Token in git credentials file
<https://www.youtube.com/watch?v=sYT71-YAzJ0>

This is possibly related to git-credential(1).

Warning: storing your PAT as plain text is not the best security
posture.


A better way to store the token is using the wallet or password
manager of the local operating system. Epicodus has instructions for
that for MacOS and Windows.

For Linux, it depends on what distribution and desktop environment or
window manager in use.

On Fedora with the Plasma desktop, use kwallet with ksshaskpass. The
first time you 'git push' ksshaskpass will open a new window for the
username. Check the box to remember username. Then it'll open a second
window for the password. Paste the token there. Check the box for it
to remember password.

Then you can 'git push' without prompt for credentials, until the
token expires.

This is the method I adopted. But I want to switch to Github CLI.

<p>
# 01-23

Installed Neovim-QT from DNF.


<p>
# 02-03

Install gh for GitHub CLI to authenticate 'git push', etc using my 
Personal Access Token, previously handled through KWallet.

