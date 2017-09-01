$Hotfix = "KB2800945"

$Results = @()

$DCs = Get-ADDomainController -Filter * # {hostname -like "gbd*"}
ForEach ($DC in $DCs){

    $Result = New-Object system.object
    $Result | Add-Member -MemberType NoteProperty -Name Server -Value $DC.HostName
    $Result | Add-Member -MemberType NoteProperty -Name OperatingSystem -Value $DC.OperatingSystem
    $FixInstalled = Get-HotFix $Hotfix -ComputerName $DC.hostname -ErrorAction SilentlyContinue


    if ( $? -eq $True ) {
        $Result | Add-Member -MemberType NoteProperty -Name Installed -Value $true
    }
    ELSE {
        $Result | Add-Member -MemberType NoteProperty -Name Installed -Value $false 
    }

    $Results += $Result
    $Result
}

Write-Output ---------

$Results | sort Installed | ft -AutoSize