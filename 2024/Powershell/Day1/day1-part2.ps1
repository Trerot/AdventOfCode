$content = Get-Content "$env:USERPROFILE\Documents\GitHub\AdventOfCode\2024\Powershell\Day1\puzzleinput.txt"
$rightArrayList = New-Object -TypeName System.Collections.ArrayList
$leftArrayList = New-Object -TypeName System.Collections.ArrayList
$content.foreach({
    $Right,$Left = $_.split("   ")
    [void]$rightArrayList.add([int]$Right)
    [void]$leftArrayList.add([int]$left)
})
# above same as part 1.
$righthash = @{} 
($rightArrayList | Group-Object).foreach({
    $righthash.add($_.name, $_.count)
})

$sum = 0 
$leftArrayList.ForEach({
    $sum+= $_ * $righthash."$_"
})
$sum