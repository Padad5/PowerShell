$ReportPath = "D:\GPOReports\SID\"
$Reports = Get-ChildItem $ReportPath -Recurse *.html
ForEach ($Report in $Reports)
{
    $ReportFullPath = $ReportPath + $Report
    $ReportContents = Get-Content -LiteralPath $Report.FullName
    if ($ReportContents -like '*Group Policy loopback processing mode</a></td><td>Enabled</td><td></td></tr>*') 
    {
        $GPONameFull = Select-String "<Title>" -LiteralPath $Report -List
        $GPOName = $GPONameFull.Line.Substring(7,$GPONameFull.line.Length-15)
        $SID = $Report.name.SubString(0,$Report.name.Length-5).ToUpper()
        $ReportXML = $ReportPath + "\" + $SID + "\" + $SID + ".xml"

        Write-Host $GPOName
        Get-Content $ReportXML | Select-String "SOMPath"
#        $Link = Get-Content $ReportXML | Select-String "SOMPath"
#        $LinkTrim = $Link.ToString().Substring(9,$Link.ToString().Length-19)
#        
#        Write-Host "Link=" $Link "LinkTrim=" $LinkTrim

    }
}
