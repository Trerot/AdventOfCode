$stuff = Get-Content .\2023\Powershell\Day9\puzzleinput.txt
$arrayoflines = New-Object -TypeName System.Collections.ArrayList
$sum = 0
foreach ($line in $stuff) {
    $numbers = $line -split ' '
    $DiffLineCounter = 0
    $previous = $numbers[0]
    $DiffLineSum = 1
    $difflinearray = New-Object -TypeName System.Collections.ArrayList
    [void]$difflinearray.add($numbers)
    while ($DiffLineSum -ne 0) {
        $diffarr = New-Object -TypeName System.Collections.ArrayList
        $i = 0
        $previous = $numbers[$i]
        for ($i = 1; $i -lt $numbers.Count; $i++) {
            $diff = $numbers[$i] - $previous
            [void]$diffarr.add($diff)
            $previous = $numbers[$i]
        }
        [void]$difflinearray.Add($diffarr)
        $numbers = $diffarr
        $difflinesum = ($diffarr | Measure-Object -Sum).Sum
    }
    [void]$arrayoflines.add($difflinearray)
    $sum += ($difflinearray.foreach({ $_[-1] }) | measure-object -sum).sum
}
$sum