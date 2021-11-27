$ports = @(222);

Remove-NetFireWallRule -DisplayName "WSL2"

New-NetFireWallRule -DisplayName "WSL2" -Direction Inbound -LocalPort $ports -Action Allow -Protocol TCP
New-NetFirewallRule -DisplayName "WSL2" -Direction Outbound -LocalPort $ports -Action Allow -Protocol TCP

$host_ip = (Get-NetIPAddress -addressFamily IPv4 | where {($_.InterfaceAlias -NotMatch 'Loopback' -and $_.InterfaceAlias -NotMatch 'vEthernet' )} | select -First 1).IPAddress
$vm_ip = bash.exe -c "hostname -I"


netsh interface portproxy reset

ForEach( $port in $ports ) {
  netsh interface portproxy add v4tov4 listenport=$port connectaddress=127.0.0.1
}

