$content = Get-Content "$env:USERPROFILE\Documents\GitHub\AdventOfCode\2024\Powershell\Day2\sampleinput.txt"
$safecounter = 0

foreach ($line in $content) {
    $badcounter = 0
    $lineSplit = $line.split(" ").ForEach({ [int]$_ })
    $safe = $true
    $linesum = 0
    #for loop starting at one. since there is nothnig to do at 0.
    $line
    for ($i = 1; $i -lt $linesplit.Count; $i++) {
        $math = $linesplit[$i - 1 ] - $linesplit[$i]
        $mathAbs = [math]::abs($math)
        # line sum is  used to make sure the absolute value is always going up.
        $LinesumCurrent = $linesum + $math
        $LinesumCurrent
        if ($mathAbs -eq 0 -or $mathAbs -gt 3 -or [math]::abs($linesumcurrent) -le [math]::abs($linesum)) {
            $safe = $false
        }
        $linesum = $LinesumCurrent
    }
    if ($safe) { $safecounter ++ }
}
$safecounter