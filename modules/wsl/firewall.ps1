$ports = @(22);

Remove-NetFireWallRule -DisplayName "WSL2"

New-NetFireWallRule -DisplayName "WSL2" -Direction Inbound -LocalPort $ports -Action Allow -Protocol TCP

netsh interface portproxy reset

ForEach( $port in $ports ) {
  netsh interface portproxy add v4tov4 listenport=$port connectaddress=127.0.0.1
}

