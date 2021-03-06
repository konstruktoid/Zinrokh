<# ESXi functions #>
Function Get-ESXi{
# Get a VMHost
$vHost = Get-VMHost | Sort-Object{Get-Random} 
$vHost
}

Function HostMaintenance{
# Put a VMHost in Maintenance mode
$h = Get-ESXi | where {$_.state -ne "Maintenance"} | Sort-Object{Get-Random} | Select -First 1
$NotMaintenance = $h | Select Name
echo "[$DateSec] Maintenance : $NotMaintenance entering Maintenance mode" | Out-File -Append $Logfile
Set-VMHost -VMHost $h -State "Maintenance" -Confirm:$false 
echo "[$DateSec] Maintenance : $NotMaintenance entered Maintenance mode" | Out-File -Append $Logfile
}

Function HostReboot{
# Reboot a VMhost forcefully
$h = Get-ESXi | Sort-Object{Get-Random} | Select -First 1
$HostReboot = $h | Select Name
echo "[$DateSec] HostReboot : Rebooting $HostReboot" | Out-File -Append $Logfile
Restart-VMHost -VMHost $h -Confirm:$false -force
echo "[$DateSec] HostReboot : $HostReboot rebooted" | Out-File -Append $Logfile
}