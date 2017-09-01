$SYSVOLDisk = @()

# Get list of DCs
$DCs = Get-ADDomainController -Filter { hostname -like "*" }
ForEach ($DC in $DCs){
    $DC.name
    $AllDisks = Get-WmiObject win32_logicaldisk -ComputerName $DC.HostName
    $SYSVOLDisk += $AllDisks | where { $_.volumename -like "*SYSVOL*" }
}

$SYSVOLDISk | select systemname,deviceID,freespace,volumename