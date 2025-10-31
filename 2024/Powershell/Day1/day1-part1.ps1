$content = Get-Content "$env:USERPROFILE\Documents\GitHub\AdventOfCode\2024\Powershell\Day1\puzzleinput.txt"
$rightArrayList = New-Object -TypeName System.Collections.ArrayList
$leftArrayList = New-Object -TypeName System.Collections.ArrayList
$content.foreach({
    $Right,$Left = $_.split("   ")
    [void]$rightArrayList.add([int]$Right)
    [void]$leftArrayList.add([int]$left)
})
$rightArrayList.sort()
$leftArrayList.sort()
$sum = 0 
for ($i = 0; $i -lt $rightArrayList.Count; $i++) {

$sum +=[Math]::Abs($rightArrayList[$i]-$leftArrayList[$i])
    <# Action that will repeat until the condition is met #>
}

$sum