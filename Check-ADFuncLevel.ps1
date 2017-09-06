$Results = @() 
$Forest = "Domain.local"
   
$DCs = Get-ADDomainController -Filter * 
   
foreach ( $DC in $DCs ) { 
    $Result = $null
    write-host Checking $DC.hostname
    $Result = [PSCustomObject] @{ 
        DC = $DC.HostName
        DomainMode = (Get-ADDomain -Server $DC.hostname).DomainMode 
        ForestMode = (Get-ADForest $Forest -Server $DC.hostname).ForestMode 
    } 
    $Results += $Result 
    $Result 
}
