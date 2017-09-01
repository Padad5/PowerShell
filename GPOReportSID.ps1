$ReportPath = "D:\GPOReports\SID\"
$gpos = Get-GPO -All
foreach ($gpo in $gpos)
{
    $gpoSID = $gpo.Id
    $ReportFullPath = $ReportPath + $gpoSID
    $ReportNameHtml = $ReportFullPath + "\" + $gpoSID + ".html"
    $ReportNameXML = $ReportFullPath + "\" + $gpoSID + ".xml"

    md $ReportFullPath -Force | Out-Null
    Write-Host $gpo.DisplayName $ReportFullPath
    Get-GPOReport -guid $gpo.id -ReportType Html -Path $ReportNameHtml
    Get-GPOReport -guid $gpo.id -ReportType xml -Path $ReportNameXML
}