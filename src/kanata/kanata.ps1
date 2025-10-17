$kanata = "${env:USERPROFILE}\kanata\kanata.exe"
$kanata_new = "$($kanata).new"

if (Test-Path $($kanata_new)) {
    Copy-Item $($kanata_new) $($kanata) -Force
}

& $($kanata) --cfg ${env:USERPROFILE}\kanata\$($args[0])
