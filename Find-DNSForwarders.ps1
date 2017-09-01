
$TotalForwarders = @()

$Servers = Get-ADDomainController -Filter * #{hostname -like "gb*"}

foreach ($Server in $Servers) {

    $Hostnames = @()
    $Forwarders = @()

    $DnsInfo = (Get-WmiObject -Class microsoftdns_server -Namespace root/microsoftdns -ComputerName $Server.Name).Forwarders

    if ($DnsInfo) {
    
        foreach ($ForwarderIp in $DnsInfo) {


            $Hostname = (Get-ADDomainController -Filter {ipv4address -eq $ForwarderIp}).Name

            $Forwarders += $ForwarderIp

            $Hostnames += $Hostname

        }

        $Properties = [pscustomobject]@{

            Server = $Server.Name
            Hostnames = $Hostnames
            Forwarders = $Forwarders

        }

        $TotalForwarders += $Properties

    }
    else {

        Write-Output "Info query failed for $($Server.Name)"

    }

}

$TotalForwarders | ft -AutoSize -Wrap
