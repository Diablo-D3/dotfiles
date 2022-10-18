$kmonad = "${env:USERPROFILE}\kmonad\kmonad-win.exe"
$kmonad_new = "$($kmonad).new"

if (Test-Path $($kmonad_new)) {
    Move-Item $($kmonad_new) $($kmonad) -Force
}

& $($kmonad) ${env:USERPROFILE}\kmonad\$($args[0])

