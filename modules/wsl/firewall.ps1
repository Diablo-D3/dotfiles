$ports = @(22);

Remove-NetFireWallRule -DisplayName "WSL2"

New-NetFireWallRule -DisplayName "WSL2" -Direction Inbound -LocalPort $ports -Action Allow -Protocol TCP

$ip = wsl hostname -I

netsh interface portproxy reset

ForEach( $port in $ports ) {
  netsh interface portproxy add v4tov4 listenport=$port connectaddress=$ip
}

