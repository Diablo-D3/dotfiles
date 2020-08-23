# Diablo-D3's dotfiles

These are my own dotfiles. I share them to make it easier for other people to understand how maintain their own. I suggest you make your own dotfiles repo from scratch, and do not fork my, or anyone else's, dotfile repo.

I use [dotbot](https://github.com/Diablo-D3/dotfiles) to automate the task.

## Installation

`git clone --recursive https://github.com/Diablo-D3/dotfiles.git ~/.dotfiles && ~/.dotfiles/install`

## Update

Run `~/.dotfiles/install` again.

Note: My `.gitmodules` are habitually set to `ignore = dirty`, and, thus, no longer tracked per revision in this repo; however, `install` also runs `git submodule update --init --recursive`, and handles the non-tracked updating of submodules.

# Other important config

[Set matching Firefox Color theme](https://github.com/TeddyDD/firefox-base16)

Note: Although I use base16 everywhere, I do not use base16-shell, but I do use 256 color terminals. The configuration of my terminals and Vim reflects this; this is considered mildly unusual.

