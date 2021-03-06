<# Virtual Machine functions #>
Function Get-vMachine{
# Get a random VM
$VM = Get-VM | Sort-Object{Get-Random} | Select -First 1
$VM
}

Function VMMem{
# Get a VM and give it 1G ram, memory hot-add required
$vmachine = Get-vMachine
echo "[$DateSec] VMMem : Setting 1G RAM on $vmachine" | Out-File -Append $Logfile
Set-VM -VM $vmachine -MemoryGB 1 -Confirm:$false
echo "[$DateSec] VMMem : 1G RAM set on $vmachine" | Out-File -Append $Logfile
}

Function VMNICConnected{
# Get a VM NetworkAdapter and disconnect it
$vmachine = Get-vMachine
$NetworkAdapter = Get-NetworkAdapter -VM $vmachine | where {$_.ConnectionState -notcontains "NotConnected"} | Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] vNICConnected : Disconnecting $NetworkAdapter on $vmachine" | Out-File -Append $Logfile
$vmachine | Set-NetworkAdapter -NetworkAdpater $NetworkAdapter -Connected:$false -StartConnected:$false -Confirm:$false
echo "[$DateSec] vNICConnected : $NetworkAdapter on $vmachine disconnected" | Out-File -Append $Logfile
}

Function VMReboot{
# Reboot a VM
$vmachine = Get-vMachine
$vMachineReboot = $vmachine | Select Name
echo "[$DateSec] vMachineReboot : Rebooting $vMachineReboot" | Out-File -Append $Logfile
$vmachine | Restart-VM -Confirm:$false
echo "[$DateSec] vMachineReboot : $vMachineReboot rebooted" | Out-File -Append $Logfile
}
