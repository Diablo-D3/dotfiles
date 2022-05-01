#
# fake init.d
#

wsl -u root service ssh restart

#
# setup firewall
#

$ports = @(222);

Remove-NetFireWallRule -DisplayName "WSL2"

New-NetFireWallRule -DisplayName "WSL2" -Direction Inbound -LocalPort $ports -Action Allow -Protocol TCP

$host_ip = (Get-NetIPAddress -addressFamily IPv4 -addressState Preferred | where {($_.InterfaceAlias -NotMatch 'Loopback' -and $_.InterfaceAlias -NotMatch 'vEthernet' )} | select -First 1).IPAddress
$vm_ip = (Get-HnsEndpoint | where {$_.VirtualNetworkName -Eq 'WSL'} | Select-Object -First 1).IPAddress

netsh interface portproxy reset

# Connecting to VM's IP instead of WSL2's localhost proxy is more reliable
ForEach( $port in $ports ) {
  netsh interface portproxy add v4tov4 listenport=$port connectaddress=$vm_ip
}

netsh interface portproxy show all

# Sometimes portproxy fails to work after reboot, this is not related to the WSL fast startup issue
Restart-Service iphlpsvc

