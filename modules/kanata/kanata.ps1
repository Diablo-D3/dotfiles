$kanata = "${env:USERPROFILE}\kanata\kanata.exe"
$kanata_new = "$($kanata).new"

if (Test-Path $($kanata_new)) {
    Move-Item $($kanata_new) $($kanata) -Force
}

& $($kanata) --cfg ${env:USERPROFILE}\kanata\$($args[0])
