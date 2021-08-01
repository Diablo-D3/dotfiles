# Diablo-D3's dotfiles

These are my own dotfiles. I share them to make it easier for other people to understand how maintain their own. I suggest you make your own dotfiles repo from scratch, and do not fork my, or anyone else's, dotfile repo.

I use [dotbot](https://github.com/anishathalye/dotbot) to automate the task. I use a custom modularized dotbot config to achieve this.

## Installation

`git clone --recursive https://github.com/Diablo-D3/dotfiles.git ~/.dotfiles && ~/.dotfiles/install`

## Update

Run `~/.dotfiles/install` again.

Note: My `.gitmodules` are habitually set to `ignore = dirty`, and, thus, no longer tracked per revision in this repo; however, `install` also runs `git submodule update --init --recursive`, and handles the non-tracked updating of submodules.

## Other important config
### Firefox

[Set matching Firefox Color theme](https://github.com/TeddyDD/firefox-base16)

Note: Although I use base16 everywhere, I do not use base16-shell, but I do use 256 color terminals. The configuration of my terminals and Vim reflects this; this is considered mildly unusual.

### Debian

I should write an actual script to standup my personal Debian VMs. Until then...

`apt install sysvinit-core bash-completion deborphan bc neovim shellcheck man-db manpages manpages-dev manpages-posix manpages-posix-dev` (remove systemd, install basic tools, install all the relevant manpages)

`apt install libpam-elogin openssh-server` (install sshd without systemd)

### opensshd on WSL2

Enable Developer Mode in Developer Settings, enable unsigned Powershell execution at the bottom, from elevated Powershell run:

`\\wsl$\Debian\home\${env:USERNAME}\.dotfiles\modules\wsl\firewall.ps1` to setup the firewall and port foward.

`\\wsl$\Debian\home\${env:USERNAME}\.dotfiles\modules\wsl\install-tasks.ps1` to install the scheduled task to start services inside of WSL2.

### Apple Multitouch

Did you know Apple doesn't want you to use the hardware you paid for on the world's most popular desktop OS? Without [this driver](https://github.com/imbushuo/mac-precision-touchpad), your multitouch touchpad is just a plain boring touchpad that can only left and right click, scroll badly, and have annoyingly coarse cursor precision; with that driver, you now have all of your usual two, three, and four finger gestures, just like in OSX, using Windows 10's native precision touchpad support.
