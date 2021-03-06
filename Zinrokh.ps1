if (!(Get-PSSnapin -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue)){
            Add-PSSnapin VMware.VimAutomation.Core
}

$Date = Get-Date -format yyMMdd
$DateSec = Get-Date -format HHmmss
$Folder = [environment]::getfolderpath("mydocuments")
$Logfile = "$Folder\Zinrokh." + $Date + ".txt"

$URnd0 = Get-random -min 50 -max 500
$URnd1 = Get-random -min 50 -max 500
$SUM = $URnd0 + $URnd1

$UInput = Read-Host "This is Zinrokh, a vSphere redundancy tester.`nIf you are really sure you know what this script does, please enter the sum of $URnd0+$URnd1 here"

if ( $UInput -ne $SUM ){
    Write-Warning "The input was incorrect. Exiting.`n"
    exit
    } else {
    echo "`nInput correct. Log file available at $Logfile`n"
    echo "[$DateSec] Input correct" | Out-File -Append $Logfile
    echo "[$DateSec] Zinrokh is starting" | Out-File -Append $Logfile
	
	# Include all settings and functions
	. ".\include\Connect.ps1"
	. ".\include\ActiveFunctions.ps1"
	. ".\include\Host.ps1"
	. ".\include\Net.ps1"
	. ".\include\VM.ps1"
    }

Function RndGetFunction{
# Get a random function

$ActiveArray = @()

	foreach ($modification in $ActiveFunctions) {
		$ActiveArray += $modification
	}

$element = Get-Random -min 1 -max $ActiveArray.Count

echo $ActiveArray[$element]
}

$Zinrokh = RndGetFunction
echo "`nExecuting function: $Zinrokh`n"
Invoke-Expression $Zinrokh

echo "[$DateSec] Zinrokh has finished" | Out-File -Append $Logfile
exit
