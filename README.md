# Diablo-D3's dotfiles

These are my own dotfiles. I share them to make it easier for other people to understand how maintain their own. I suggest you make your own dotfiles repo from scratch, and do not fork my, or anyone else's, dotfile repo.

## Installation

`git clone --recursive https://github.com/Diablo-D3/dotfiles.git ~/.dotfiles && ~/.dotfiles/install`

## Update

Run `~/.dotfiles/install` again.

## Other important config

### Debian

I should write an actual script to standup my personal Debian VMs (or use one of the thousands of tools for this). Until then...

`sudo apt install sysvinit-core openssh-server libpam-elogin bash-completion bc deborphan file git wget neovim shellcheck` (remove systemd, install sshd without systemd dep, install basic tools)

`sudo apt install man-db manpages manpages-dev manpages-posix manpages-posix-dev` (install all the relevant manpages)

### opensshd on WSL2

Enable Developer Mode in Developer Settings, enable unsigned Powershell execution at the bottom, from an elevated Powershell run:

`. \\wsl$\Debian\home\${env:USERNAME}\.dotfiles\modules\wsl\install-tasks.ps1` [&#10149;](./modules/wsl/install-tasks.ps1) to install the scheduled tasks (of `init.ps1` [&#10149;](./modules/wsl/init.ps1) and `firewall.ps1` [&#10149;](./modules/wsl/firewall.ps1), using `hidden_powershell`[&#10149;](./modules/wsl/hidden_powershell.js)  to start services inside of WSL2 upon Windows user login.

### Apple Multitouch

Did you know Apple doesn't want you to use the hardware you paid for on the world's most popular desktop OS? Without [this driver](https://github.com/imbushuo/mac-precision-touchpad), your multitouch touchpad is just a plain boring touchpad that can only left and right click, scroll badly, and have annoyingly coarse cursor precision; with that driver, you now have all of your usual two, three, and four finger gestures, just like in OSX, using Windows 10's native precision touchpad support.

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

