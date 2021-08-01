$ports = @(22);

Remove-NetFireWallRule -DisplayName "WSL2"

New-NetFireWallRule -DisplayName "WSL2" -Direction Outbound -LocalPort $ports -Action Allow -Protocol TCP
New-NetFireWallRule -DisplayName "WSL2" -Direction Inbound -LocalPort $ports -Action Allow -Protocol TCP

ForEach( $port in $ports ) {
  netsh interface portproxy delete v4tov4 listenport=$port
  netsh interface portproxy add v4tov4 listenport=$port connectaddress=127.0.0.1
}

