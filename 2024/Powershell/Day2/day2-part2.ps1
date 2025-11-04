$content = Get-Content "$env:USERPROFILE\Documents\GitHub\AdventOfCode\2024\Powershell\Day2\puzzleinput.txt"
$safecounter = 0

foreach ($line in $content) {
    $lineSplit = $line.split(" ").ForEach({ [int]$_ })
    $safe = $true
    $linesum = 0
    $ProblemDampener = $true
    #for loop starting at one. since there is nothnig to do at 0.
    for ($i = 1; $i -lt $linesplit.Count; $i++) {
        $math = $linesplit[$i - 1 ] - $linesplit[$i]
        $mathAbs = [math]::abs($math)
        # line sum is  used to make sure the absolute value is always going up.
        $LinesumCurrent = $linesum + $math
        if ($mathAbs -eq 0 -or $mathAbs -gt 3 -or [math]::abs($linesumcurrent) -le [math]::abs($linesum)) {
            if ($ProblemDampener) {
                $lineSplit.Removeat($i-1)
                $linesum = 0
                $i = 1
                $safe = $true
                $ProblemDampener = $false     
            }
            else {
                $safe = $false
            }
        
        
         
    }
    $linesum = $LinesumCurrent
}
if ($safe) { $safecounter ++ }
}
$safecounter

# 556 to high
# 546 not right.
# 502 to low