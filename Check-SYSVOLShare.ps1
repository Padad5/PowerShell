$Results = @()

# Get list of DCs
$DCs = Get-ADDomainController -Filter *
ForEach ($DC in $DCs){
    # Check that SYSVOL and NETLOGON can be accessed on each DC
    $SYSVOLCheck = Test-Path \\$($DC.hostname)\SYSVOL
    $NETLOGONCheck = Test-Path \\$($DC.hostname)\NETLOGON
    # Add results into a PS object
    $Result = [PSCustomObject] @{
        DC = $DC.name
        SYSVOL = $SYSVOLCheck 
        NETLOGON = $NETLOGONCheck
    }
    $Results += $Result
}

# Output any DC that doesn't have have SYSVOL or NETLOGON shared
$Results | where { $_.SYSVOL -eq $false -or $_.NETLOGON -eq $false } | ft -AutoSize
