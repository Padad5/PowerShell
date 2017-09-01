$DCs = Get-ADDomainController -Filter * #{hostname -like "gb*"}
ForEach ($DC in $DCs){
    # Write-Host $DC.HostName
    $ZoneNames = dnscmd $DC.HostName /enumzones /primary /forward
        foreach ($ZoneName in $ZoneNames){
            $ZoneSplit = $ZoneName.Split(" ")[1]
            $ZoneInfo = dnscmd $DC.HostName /ZoneInfo $ZoneSplit | Select-String "secure secs           = 0"
          #  $ZoneSplit
            if ($ZoneInfo -gt $null){Write-Host $DC.Name $ZoneSplit}

        }
}