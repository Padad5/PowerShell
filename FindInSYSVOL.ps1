
$Search = "Morphtest_654321"

$Results = @()

$DCs = Get-ADDomainController -Filter {hostname -like "gb*"}
ForEach ($DC in $DCs){
    $Command = "\\" + $DC.hostname + "\SYSVOL\Rolls-Royce.Local\Policies\*" + $Search + "*"
    # cmd /c dir $Command /s/b
    # Write-Host $Command
    Write-output $DC.hostname
    $Result = (Get-ChildItem $Command -Directory -Recurse -ErrorAction SilentlyContinue).FullName
    Write-output $Result
    # $Result.ToString()
    $Results += $Result
}