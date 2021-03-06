<# Net functions #>
Function NetAdapterBitRate{
# Get a physical VMHostNetworkAdapter, set BitRatePerSecMb to 10 and Duplex to full 
$h = Get-ESXi
$NetworkAdapter = Get-VMHostNetworkAdapter -VMHost $h -Physical | Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] NetworkAdapter : Setting BitRatePerSecMb to 10 on $NetworkAdapter on $h" | Out-File -Append $Logfile
$NetworkAdapter | Set-VMHostNetworkAdapter -BitRatePerSecMb 10 -Duplex full -Confirm:$false
echo "[$DateSec] NetworkAdapter : BitRatePerSecMb 10 on $NetworkAdapter on $h is set" | Out-File -Append $Logfile
}

Function NetFullDuplex{
# Get a VMHostNetworkAdapter, set Duplex to half and a random BitRatePerSecMb
$h = Get-ESXi
$RndBitRate = Get-Random -InputObject '10','100','1000','10000'
$FullDuplex = Get-VMHostNetworkAdapter -VMHost $h | where {$_.FullDuplex -eq "True"} |Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] NetworkFullDuplex : Setting Halfduplex and BitRatePerSecMb to $RndBitRate on $FullDuplex on $h" | Out-File -Append $Logfile
$FullDuplex | Set-VMHostNetworkAdapter -Duplex half -BitRatePerSecMb $RndBitRate -Confirm:$false
echo "[$DateSec] NetworkFullDuplex : Halfduplex and BitRatePerSecMb to $RndBitRate on $FullDuplex on $h is set" | Out-File -Append $Logfile
}

Function NetRndVLAN{
# Get a VirtualPortGroup and set VLanID to a random number between 0-4095
$h = Get-ESXi
$VLanID = Get-Random -min 0 -max 4095
$RndVLAN = $h | Get-VirtualPortGroup | Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] RndVLAN : Setting VLanID to $VLanID on $RndVLAN on $h" | Out-File -Append $Logfile
Set-VirtualPortGroup -VirtualPortGroup $RndVLAN -VLanId $VLanID -Confirm:$false
echo "[$DateSec] RndVLAN : VLanID $VLanID on $RndVLAN on $h is set" | Out-File -Append $Logfile
}

Function NetSwitchAdapter{
# Remove a physical NIC from a standard virtual switch
$h = Get-ESXi
$NetworkAdapter = $h | Get-VMHostNetworkAdapter -Physical | Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] RndVLAN : Removing $NetworkAdapter from vSwitch on $h" | Out-File -Append $Logfile
$NetworkAdapter | Remove-VirtualSwitchPhysicalNetworkAdapter -Confirm:$false
echo "[$DateSec] RndVLAN : Removed $NetworkAdapter from vSwitch on $h" | Out-File -Append $Logfile
}

Function NetSwitchMTU{
# Get a vSwitch, set a random MTU
$h = Get-ESXi
$RndMTU = Get-Random -min 1280 -max 9000
$vSwitch = Get-VirtualSwitch -VMHost $h | Sort-Object{Get-Random} | Select -First 1
echo "[$DateSec] vSwitch : Setting $vSwitch MTU $RndMTU on $h" | Out-File -Append $Logfile
Set-VirtualSwitch -VirtualSwitch $vSwitch -MTU $RndMTU -Confirm:$false
echo "[$DateSec] vSwitch : MTU $RndMTU set on $vSwitch" | Out-File -Append $Logfile
}
