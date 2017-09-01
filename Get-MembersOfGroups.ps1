$groups = "Domain Admins","Administrators","Enterprise Admins","Schema Admins","Account Operators","Backup Operators","Server Operators"
$Results = @()

foreach ( $group in $groups ) {
    Write-Output Processing $group
    
    $GroupMembers = Get-ADGroupMember $group -Recursive
    $Members = ($GroupMembers | Measure-Object).count

    $Result = [pscustomobject] @{
        Group = $group
        Members = $Members
    }

    $Results += $Result
}


