$gpos = Get-GPO -All
foreach ($gpo in $gpos)
{
    $ReportName = "D:\GPOReports\" + $gpo.DisplayName + ".html"
    Write-Host $gpo.DisplayName $ReportName
    Get-GPOReport -Name $gpo.DisplayName -ReportType Html -Path $ReportName
}