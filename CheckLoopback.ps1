$ReportPath = "D:\GPOReports\"
$Reports = Get-ChildItem $ReportPath *.html
ForEach ($Report in $Reports)
{
    $ReportFullPath = $ReportPath + $Report
    $ReportContents = Get-Content -LiteralPath $ReportFullPath
    if ($ReportContents -like '*Group Policy loopback processing mode</a></td><td>Enabled</td><td></td></tr>*') 
    {
        $GPONameFull = Select-String "<Title>" -LiteralPath $Report -List
 #       $GPOName = $GPONameFull.Line.Trim("<title>","<`/")
        $GPOName = $GPONameFull.Line.Substring(7,$GPONameFull.line.Length-15)
        Write-Host "Found" $GPOName 
    }
}
