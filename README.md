# Diablo-D3's dotfiles

These are my own dotfiles. I share them to make it easier for other people to understand how maintain their own. I suggest you make your own dotfiles repo from scratch, and do not fork my, or anyone else's, dotfile repo.

## Installation

`git clone --recursive https://github.com/Diablo-D3/dotfiles.git ~/.dotfiles && ~/.dotfiles/install`

## Update

Run `~/.dotfiles/install` again.

## Other important config

### Debian

I should write an actual script to standup my personal Debian VMs (or use one of the thousands of tools for this). Until then...

`sudo apt install sysvinit-core openssh-server libpam-elogind bash-completion bc deborphan file fzf fd-find git wget rsync` (remove systemd, install sshd without systemd dep, install basic tools)

`sudo apt install emacs-nox fd-find ripgrep shellcheck shfmt` (everything required for emacs)

`sudo apt install man-db manpages manpages-dev manpages-posix manpages-posix-dev` (install all the relevant manpages)

### opensshd on WSL2

Enable Developer Mode in Developer Settings, enable unsigned Powershell execution at the bottom, from an elevated Powershell run:

`. \\wsl$\Debian\home\${env:USERNAME}\.dotfiles\modules\wsl\install-task.ps1` [&#10149;](./modules/wsl/install-task.ps1) to install the scheduled task of `wsl.ps1` [&#10149;](./modules/wsl/wsl2.ps1), using `hidden_powershell`[&#10149;](./modules/wsl/hidden_powershell.js) to start services inside of WSL2 and properly setup the Windows firewall and port forwarding upon Windows user login.

### Apple Multitouch

Did you know Apple doesn't want you to use the hardware you paid for on the world's most popular desktop OS? Without [this driver](https://github.com/imbushuo/mac-precision-touchpad), your multitouch touchpad is just a plain boring touchpad that can only left and right click, scroll badly, and have annoyingly coarse cursor precision; with that driver, you now have all of your usual two, three, and four finger gestures, just like in OSX, using Windows 10's native precision touchpad support.

## On font sizes

Kids these days use font sizes that are too small, historically.

The DEC VT100 (from 1978) is what most people consider the grandfather of all modern terminals because it was the first terminal to have a 80x24 layout with ANSI control codes (wasn't the first that did either feature by itself). It also supported a 132 wide mode, but with far less rows; most people didn't use 132 because the font was rendered condensed and was difficult to read.

[The specs](https://archive.org/details/bitsavers_decterminaT100TechnicalManualJul82_24218672/page/n19/mode/2up?view=theater) lists a 12" CRT, but an "active display size" of 8" x 5" (or 9.43" diagonally); photographs of the VT100 prove this to be correct. [According to this guy](https://www.pcjs.org/machines/dec/vt100/rom/), it's a 7x9 font that is rendered with "dot stretching" to produce an 8x9 font that is rendered into 10x10 cells onto a 800x240 screen, then line doubled to 800x480, making the final character size 10x20.

Fastforward to the modern day: the most common desktop monitor size is a 24" 1080p (or 20.9" wide and 11.8" tall); keeping approximate apparent size the same...

```
80 / 8 * 20.9 = 209 cols
1920 / 209 = 9.19 pixels wide
24 / 5 * 11.8 = 56.64 lines
1080 / 56.64 = 19.06 pixels high
```

.. rounding up the character size a little to get integers everywhere, gives us a 10x20 font and a 192x54 terminal. The DPI of the VT100 and my monitor are almost identical, thus leading to the same font size.

MDA/CGA/EGA/VGA monitors that were 12-14" would be slightly lower resolution (ex: 9x14 character size at 720x350, producing a 80x25 terminal), and using the same approximate math, it would have an apparent size of closer to 12x30 on 160x36 terminal.

#### Sizes tested in Windows Terminal

| Name                |  Size | Layout |  Size | Layout |
|---------------------|------:|--------|------:|--------|
| Lucida Console      |    12 | 192x60 |    15 | 160x51 |
| Anonymous Pro       |    14 | 192x56 |    16 | 160x47 |
| Fira Mono           |    12 | 192x54 |    15 | 160x45 |
| Input               |    12 | 192x54 |    14 | 160x45 |
| Bitstream Vera Mono |    12 | 192x54 |    15 | 160x45 |
| Cascadia            |    13 | 192x54 |    15 | 160x45 |
| Courier New         |    13 | 192x54 |    15 | 160x45 |
| Iosevka Extended    |    13 | 192x54 |    15 | 160x45 |
| *24" Faux VT100*    | 10x20 | 192x54 |       |        |
| Consolas            |    13 | 192x49 |    16 | 160x40 |
| Source Code Pro     |    13 | 192x49 |    15 | 160x41 |
| Terminus TTF        |    15 | 192x47 |    18 | 160x39 |
| *24" Faux CGA*      |       |        | 12x30 | 160x36 |
| Iosevka             |    15 | 192x41 |    18 | 160x34 |

## On repository management

I do not use `git submodule', 'subtree', or ['subrepo'](https://github.com/ingydotnet/git-subrepo). All have their uses, none of them align with dotfile repos.

### `git submodule` vs `git subtree` vs `git subrepo`

`submodule` only makes sense if you're using git as a package manager to enforce version dependencies in the form of git refs. It makes absolutely no sense to use this to merely name external repos whose exact version is meaningless; as in, you wish to track the external repo's branch, not a ref or a tag, as you are not making a system that ensures repeatable builds. `subtree` and `subrepo` exist for this purpose. 90% of `submodule` use should be moved to `subtree`/`subrepo` instead, or actually use a package manager intended for your actual language domain (ex: Javascript, Python, and Perl all have this aspect to their culture; there is no good generic git clone manager, however).

### How do you use `subtree` optimally?

Since this is a dotfiles repo, lets go with a relevant example: a vim plugin named bar.vim with a remote url `https://github.com/foo/bar.vim`.

To add it: `git remote add -f bar.vim https://github.com/foo/bar.vim && git subtree add --squash --prefix=modules/vim/site/pack/bar.vim bar.vim main`

To update it: `git fetch bar.vim main && git subtree pull --squash --prefix=modules/vim/site/pack/bar.vim bar.vim main`

The command structure is a bit more complex than I'd like, and is not very DRY.

### How do you use `subrepo`, then?

You should read the [README for `subrepo`](https://github.com/ingydotnet/git-subrepo), but following the above example...

To add it: `git subrepo clone -b master https://github.com/foo/bar.vim ./modules/vim/site/pack/bar.vim`

To update it: `git subrepo pull ./modules/vim/site/pack/bar.vom`

To update all: `git subrepo pull --all`

Notice this is far easier to use, and works a lot like `git` already does.

