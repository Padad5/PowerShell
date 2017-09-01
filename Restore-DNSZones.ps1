$DNSServer = "DC1"
$Zones = Import-Csv .\DNS.CSV

$Zones | foreach {
    $Zone=$_.name
    $Master=$_.MasterServers
    $Second=$_.SecondaryServers

    #Write-Output Zone: $Zone
    #Write-Output Master: $Master
    #Write-Output Second: $Second

    Switch ($_.ZoneType) {
       
        2 {$cmd1=”dnscmd {0} /ZoneAdd {1} /secondary {2}” -f $DNSServer,$Zone,$Master 
            $cmd2="dnscmd {0} /ZoneResetSecondaries {1} {2}" -f $DNSServer,$Zone,$Second
          }
        3 {$cmd1=”dnscmd {0} /ZoneAdd {1} /stub {2}” -f $DNSServer,$Zone,$Master }
        4 {$cmd1=”dnscmd {0} /ZoneAdd {1} /forwarder {2}” -f $DNSServer,$Zone,$Master }
    }

    Write-Output $cmd1
    Write-Output $cmd2
    
    cmd /c $cmd1
    cmd /c $cmd2

    Clear-Variable cmd2


}