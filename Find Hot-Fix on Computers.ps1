$Hotfix = "kb4012212"

$Results = @()

$Comps = Get-ADComputer -Filter {samaccountname -like "gb*ccm*"} -Properties operatingsystem
ForEach ($Comp in $Comps){

    $Result = New-Object system.object
    $Result | Add-Member -MemberType NoteProperty -Name Server -Value $Comp.Name
    $Result | Add-Member -MemberType NoteProperty -Name OperatingSystem -Value $Comp.OperatingSystem
    
    $FixInstalled = Get-HotFix $Hotfix -ComputerName $Comp.Name -ErrorAction SilentlyContinue


    if ( $? -eq $True ) {
        $Result | Add-Member -MemberType NoteProperty -Name "$Hotfix Installed" -Value $true
    }
    ELSE {
        $Result | Add-Member -MemberType NoteProperty -Name "$Hotfix Installed" -Value $false 
    }

    $Results += $Result
    $Result
}

Write-Output ---------

$Results | sort Installed | ft -AutoSize