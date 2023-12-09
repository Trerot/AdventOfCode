$stuff = Get-Content .\2023\Powershell\Day9\puzzleinput.txt
$arrayoflines = New-Object -TypeName System.Collections.ArrayList
$sum = 0
$negsum = 0
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
    # negative here
    $firsts = $difflinearray.foreach({ $_[0] })
    $numby = 0
   # $difflinearray.foreach({ $_ -join ',' })
    for ($i = $firsts.count; $i -gt 0; $i--) {
        if($firsts.count -eq $i){
            $numby = $firsts[$i-1]-$firsts[$i]
        }
        $numby=  $firsts[$i-1]-$numby
        <# Action that will repeat until the condition is met #>

    }
    $negsum += $numby
}
# should be
# -3
#  0 
# 5
#$sum
$negsum