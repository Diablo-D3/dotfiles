# Based on Kory Gill / https://stackoverflow.com/a/39378046/687157

function Invoke-ScheduledTask {
  param (
      $TaskName,
      $Admin,
      $Command,
      $Arguments
  )

  $task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

  if ($task -ne $null) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false 
  }

  $action = New-ScheduledTaskAction -Execute "$Command" -Argument "$Arguments"
  $trigger = New-ScheduledTaskTrigger -AtLogon -User "${env:USERNAME}"
  $settings = New-ScheduledTaskSettingsSet -Compatibility Win8 -AllowStartIfOnBatteries

  if ($Admin -eq $true) {
    $runlevel = "Highest"
  } else {
    $runlevel = "Limited"
  }

  $principal = New-ScheduledTaskPrincipal -UserId "${env:USERNAME}" -Runlevel "$runlevel" -LogonType ServiceAccount

  $definition = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings -Description "Run $($TaskName) at startup"

  Register-ScheduledTask -TaskName $TaskName -InputObject $definition

  $task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

  if ($task -ne $null) {
    Write-Output "'$($TaskName)': created."
  } else {
    Write-Output "'$($TaskName)': failed."
  }
}

$path = "\\wsl$\Debian\home\${env:USERNAME}\.dotfiles\modules\wsl"

Invoke-ScheduledTask -TaskName "WSL2 init.d" -Admin $false -Command "wscript.exe" -Arguments "${path}\hidden_powershell.js ${path}\init.ps1"
Invoke-ScheduledTask -Taskname "WSL2 Firewall" -Admin $true -Command "wscript.exe" -Arguments "${path}\hidden_powershell.js ${path}\firewall.ps1"

