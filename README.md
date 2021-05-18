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

### opensshd on Windows

Microsoft ships an odd configuation with OpenSSH. Working install instructions, in elevated Powershell:

1. `Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'` - Get version here
2. `Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0` - Replace version here
3. Edit `c:\ProgramData\ssh\sshd_config` to uncomment `PasswordAuthentication` and set to `no`, and comment out the `Match Group administrators` block at the bottom
4. `New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\msys64\sshd_msys2.bat" -PropertyType String -Force`
5. `Set-Service -Name sshd -StartupType 'Automatic'`
6. `Start-Service sshd`
7. `icacls.exe "$($env:USERPROFILE)\.ssh\authorized_keys" /inheritance:r /grant "$($env:USERNAME):F" /grant "NT AUTHORITY\SYSTEM:F"` to fix permissions

### Apple Multitouch

Did you know Apple doesn't want you to use the hardware you paid for on the world's most popular desktop OS? Without [this driver](https://github.com/imbushuo/mac-precision-touchpad), your multitouch touchpad is just a plain boring touchpad that can only left and right click, scroll badly, and have annoyingly coarse cursor precision; with that driver, you now have all of your usual two, three, and four finger gestures, just like in OSX, using Windows 10's native precision touchpad support.
