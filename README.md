# Diablo-D3's dotfiles

These are my own dotfiles. I share them to make it easier for other people to understand how maintain their own. I suggest you make your own dotfiles repo from scratch, and do not fork my, or anyone else's, dotfile repo.

## Installation

`git clone --recursive https://github.com/Diablo-D3/dotfiles.git ~/.dotfiles && ~/.dotfiles/install`

## Update

Run `~/.dotfiles/install` again.

## Other important config

### Debian

I should write an actual script to stand-up my personal Debian VMs (or use one of the thousands of tools for this). Until then...

`sudo apt install sysvinit-core openssh-server libpam-elogind bash-completion bc deborphan file git lsb-release vim rsync wget` (remove systemd, install sshd without systemd dep, install basic tools)

`sudo apt install fzf fd-find ripgrep tmux` (currently separated out because they pull in unstable/experimental versions, don't do this on low disk space VMs)

`sudo apt install neovim shellcheck python3-venv` (everything required for neovim)

`sudo apt install man-db manpages manpages-dev manpages-posix manpages-posix-dev` (install all the relevant manpages)

### opensshd on WSL2

Enable Developer Mode in Developer Settings, enable unsigned Powershell execution at the bottom, from an elevated Powershell run:

`. ${env:USERPROFILE}\install-task.ps1 WSL2 wsl2.ps1` [&#10149;](./modules/os-wsl/install-task.ps1) to install the scheduled task of `wsl.ps1` [&#10149;](./modules/os-wsl/wsl2.ps1), using `hidden_powershell`[&#10149;](./modules/os-wsl/hidden_powershell.js) to start services inside of WSL2 and properly setup the Windows firewall and port forwarding upon Windows user login.

### Kanata on Windows

`. ${env:USERPROFILE}\install-task.ps1 kanata kanata\kanata.ps1 name.kbd` to install kanata as a service [&#10149;](./modules/os-wsl/kanata.ps1); includes copying `kanata.exe.new` to `kanata.exe` to facilitate seamless upgrades.

### Apple Multitouch

Did you know Apple doesn't want you to use the hardware you paid for on the world's most popular desktop OS? Without [this driver](https://github.com/imbushuo/mac-precision-touchpad), your multitouch touchpad is just a plain boring touchpad that can only left and right click, scroll badly, and have annoyingly coarse cursor precision; with that driver, you now have all of your usual two, three, and four finger gestures, just like in OSX, using Windows 10's native precision touchpad support.

## On fonts and font sizes

Kids these days use font sizes that are too small, historically.

The DEC VT100 (from 1978) is what most people consider the grandfather of all modern terminals because it was the first terminal to have a 80x24 layout with ANSI control codes (wasn't the first that did either feature by itself). It also supported a 132 wide mode, but with far less rows; most people didn't use 132 because the font was rendered condensed and was difficult to read.

[The specs](https://archive.org/details/bitsavers_decterminaT100TechnicalManualJul82_24218672/page/n19/mode/2up?view=theater) lists a 12" CRT, but an "active display size" of 8" x 5" (or 9.43" diagonally); photographs of the VT100 prove this to be correct. [According to this guy](https://www.pcjs.org/machines/dec/vt100/rom/) and [this guy](https://www.masswerk.at/nowgobang/2019/dec-crt-typography), it's a 7x9 font that is rendered with "dot stretching" to produce an 8x9 font that is rendered into 10x10 cells onto a 800x240 screen, then line doubled to 800x480, making the final character size 10x20.

Fast-forward to the modern day: the most common desktop monitor size is a 24" 1080p (or 20.9" wide and 11.8" tall); keeping approximate apparent size the same...

```
80 / 8 * 20.9 = 209 cols
1920 / 209 = 9.19 pixels wide
24 / 5 * 11.8 = 56.64 lines
1080 / 56.64 = 19.06 pixels high
```

... rounding up the character size a little to get integers everywhere, gives us a 10x20 font and a 192x54 terminal. The DPI of the VT100 and my monitor are almost identical, thus leading to the same font size.

MDA/CGA/EGA/VGA monitors that were 12-14" would be slightly lower resolution (ex: 9x14 character size at 720x350, producing a 80x25 terminal), and using the same approximate math, it would have an apparent size of closer to 12x30 on 160x36 terminal.

[https://int10h.org/oldschool-pc-fonts/fontlist/](int10h.org) maintains a library of old bitmap fonts from old machines.

#### Sizes tested in Windows Terminal and Alacritty

Note: Windows Terminal and Alacritty do not agree on cell height; often, Alacritty needs `font.offset.x = 1` and/or `font.offset.y = 1` to match WT's spacing, WT currently has no method to adjust cell size, but there is an open issue for it.

Sorted from widest to tallest

| Name                |  Size | Layout |  Size | Layout |
| ------------------- | ----: | ------ | ----: | ------ |
| MonoLisa            |    11 | 192x61 |    13 | 160x52 |
| Lucida Console      |    12 | 192x60 |    15 | 160x51 |
| Anonymous Pro       |    14 | 192x56 |    16 | 160x47 |
| Hack                |    12 | 192x56 |    15 | 160x45 |
| Monoid              |    11 | 192x54 |    13 | 160x47 |
| Input               |    12 | 192x54 |    14 | 160x45 |
| JuliaMono           |    12 | 192x54 |    14 | 160x45 |
| Bitstream Vera Mono |    12 | 192x54 |    15 | 160x45 |
| Fira Mono           |    12 | 192x54 |    15 | 160x45 |
| Fira Code           |    12 | 192x54 |    15 | 160x45 |
| Cascadia            |    13 | 192x54 |    15 | 160x45 |
| Courier New         |    13 | 192x54 |    15 | 160x45 |
| Iosevka Extended    |    13 | 192x54 |    15 | 160x45 |
| _24" Faux VT100_    | 10x20 | 192x54 |       |        |
| IBM Plex Mono       |    12 | 192x54 |    15 | 160x40 |
| Jetbrains Mono      |    12 | 192x54 |    16 | 160x41 |
| Berkeley Mono       |    12 | 192x54 |    15 | 160x43 |
| Inconsolata         |    15 | 192x51 |    18 | 160x41 |
| Mplus Code Latin 60 |    12 | 192x51 |    15 | 160x43 |
| Hasklig             |    13 | 192x49 |    15 | 160x41 |
| Source Code Pro     |    13 | 192x49 |    15 | 160x41 |
| Sudo                |    17 | 192x49 |    19 | 160x40 |
| Consolas            |    13 | 192x49 |    16 | 160x40 |
| Victor Mono         |    14 | 192x47 |    16 | 160x41 |
| Terminus TTF        |    15 | 192x47 |    18 | 160x39 |
| _24" Faux CGA_      |       |        | 12x30 | 160x36 |
| Mplus Code 60       |    13 | 192x43 |    15 | 160x36 |
| Mplus Code Latin 50 |    15 | 192x43 |    18 | 160x36 |
| Iosevka             |    15 | 192x41 |    18 | 160x34 |
| Mplus Code 50       |    15 | 192x36 |    18 | 160x30 |

#### Optimal rendering of common fonts

I looked for the minimum size that glyphs are easily disernable and have no excessive fringing or misshapen glyph stems. Tested using both DirectWrite (via Windows Terminal) and Freetype (using Alacritty); also tested across aliased, greyscale, and subpixel in WT.

For sanity and reproducability reasons, I tested integer pixel values only. Point values are listed in 96/100% DPI points.

Sorted by smallest legitable size, and if multiple styles, by best scoring width/weight (in italic).

| Name            | Width/Variant   |   Weight | Points  | Pixels |   Layout |
| --------------- | --------------- | -------: | ------- | -----: | -------: |
| Terminus TTF    |                 |  Regular | 9       |     12 |   240x67 |
| Berkeley Mono   |                 |  Regular | 9.75    |     13 |   240x63 |
| Sudo            |                 |   Normal | 17.25   |     23 |   192x47 |
|                 |                 | _Medium_ | _13.5_  |   _18_ | _240x60_ |
| IBM Plex        |                 |   Normal | 14.25   |     19 |   174x35 |
|                 |                 | _Medium_ | _10.5_  |   _14_ | _240x60_ |
| Input           | Normal          |  Regular | 16.5    |     22 |   137x41 |
|                 | Normal          |   Medium | 11.25   |     15 |   192x60 |
|                 | Narrow          |  Regular | 17.25   |     23 |   137x40 |
|                 | Narrow          |   Medium | 12      |     18 |   192x56 |
|                 | Condensed       |  Regular | 18      |     24 |   137x37 |
|                 | Condensed       | _Medium_ | _11.25_ |   _15_ | _213x60_ |
|                 | Compressed      |  Regular | 19.5    |     26 |   137x34 |
|                 | Compressed      |   Medium | 12.75   |     17 |   213x51 |
| Fira Mono       |                 |   Normal | 13.5    |     18 |   174x49 |
|                 |                 | _Medium_ | _11.25_ |   _15_ | _213x60_ |
| Cascadia        |                 |  Regular | 15      |     20 |   160x45 |
|                 |                 | _Medium_ | _12_    |   _16_ | _213x56_ |
| Mplus           | 1 Code          |   Normal | 15.75   |     20 |   174x38 |
|                 | _1 Code_        | _Medium_ | _12.75_ |   _17_ | _213x47_ |
|                 | Code 50         |   Normal | 15.75   |     20 |   174x32 |
|                 | Code 50         |   Medium | 12.75   |     17 |   213x40 |
|                 | Code Latin 50   |   Normal | 15.75   |     21 |   174x38 |
|                 | _Code Latin 50_ | _Medium_ | _12.75_ |   _17_ | _213x47_ |
|                 | Code 60         |   Normal | 15.75   |     21 |   147x32 |
|                 | Code 60         |   Medium | 12      |     16 |   192x43 |
|                 | Code Latin 60   |   Normal | 15.75   |     21 |   147x38 |
|                 | Code Latin 60   |   Medium | 12      |     16 |   192x51 |
| Fira Code       |                 |  Regular | 15.75   |     21 |   147x43 |
|                 |                 | _Medium_ | _13.5_  |   _18_ | _192x54_ |
| Source Code Pro |                 |  Regular | 13.5    |     18 |   174x47 |
|                 |                 | _Medium_ | _12_    |   _16_ | _192x54_ |
| Hasklig         |                 |  Regular | 13.5    |     18 |   174x47 |
|                 |                 | _Medium_ | _12_    |   _16_ | _192x54_ |
| Hack            |                 |  Regular | 15.75   |     21 | _192x54_ |
| Consolas        |                 |  Regular | 13.5    |     16 |   192x49 |
| Lucida Console  |                 |  Regular | 13.5    |     18 |   174x60 |
| Iosevka         |                 |  Regular | 18.75   |     25 |   147x34 |
|                 |                 | _Medium_ | _15_    |   _20_ | _192x43_ |
| Anonymous Pro   |                 |  Regular | 20.25   |     27 |   128x40 |
| Courier New     |                 |  Regular | 27.75   |     37 |    87x25 |
| JuliaMono       |                 |  Regular | 17.25   |     23 |   137x38 |
|                 |                 | _Medium_ | _15_    |   _20_ | _160x45_ |
| Monoid          |                 |  Regular | 18      |     20 |   120x33 |
| Jetbrains Mono  |                 |  Regular | 15.75   |     20 |   147x40 |
|                 |                 | _Medium_ | _14.25_ |   _19_ | _174x43_ |
| Victor Mono     |                 |  Regular | 18      |     24 |   147x37 |
|                 |                 | _Medium_ | _15_    |   _20_ | _174x43_ |
| Inconsolata     | Normal          |  Regular | 20.25   |     27 |   137x38 |
|                 | _Normal_        | _Medium_ | _18_    |     24 | _160x41_ |
|                 | Ultra Expanded  |  Regular | 16.5    |     22 |    87x47 |
|                 | Ultra Expanded  |   Medium | 16.5    |     22 |    87x47 |
|                 | Extra Expanded  |  Regular | 18      |     24 |   106x41 |
|                 | Extra Expanded  |   Medium | 18      |     24 |   106x41 |
|                 | Expanded        |  Regular | 20.25   |     27 |   120x38 |
|                 | Expanded        |   Medium | 18      |     24 |   137x41 |
|                 | Semi Expanded   |  Regular | 18      |     24 |   147x41 |
|                 | Semi Expanded   |   Medium | 18      |     24 |   147x41 |
|                 | Semi Condensed  |  Regular | 24      |     32 |   137x32 |
|                 | Semi Condensed  |   Medium | 21.75   |     29 |   147x34 |
|                 | Condensed       |  Regular | 23.25   |     31 |   160x32 |
|                 | Condensed       |   Medium | 22.5    |     30 |   160x33 |
|                 | Extra Condensed |  Regular | 24      |     32 |   174x32 |
|                 | Extra Condensed |   Medium | 22.5    |     30 |   174x33 |
|                 | Ultra Condensed |  Regular | 28.5    |     38 |   192x27 |
|                 | Ultra Condensed |   Medium | 27.75   |     37 |   213x27 |
| MonoLisa        |                 |  Regular | 15      |     20 |   147x54 |
|                 |                 |   Medium | 15      |     20 |   147x54 |
| Cousine         |                 |   Normal | 16.5    |     22 |   147x43 |

## On repository management

I do not use `git submodule`, `subtree`, or [`subrepo`](https://github.com/ingydotnet/git-subrepo). All have their uses, none of them align with dotfile repos.

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
