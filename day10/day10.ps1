$stuff = get-content .\day10\input.txt
#$stuff = get-content .\day10\sample.txt

$Global:cycleCounter = 0
$Global:XValue = 1
$Global:multiCycle = 20
$Global:StrengthArray = New-Object -TypeName System.Collections.ArrayList
function Invoke-XMultiplier {
    if ($Global:cycleCounter -eq $Global:multiCycle) {
        $strength = $Global:XValue * $Global:multiCycle
        $Global:StrengthArray.add($strength)
        $Global:multiCycle += 40
    }
    
}
function Process-Stuffline {
    param (
        $line
    )
    process {
        if ($line -eq "noop") {
            $value = $null 
            $Global:cycleCounter ++
            Invoke-XMultiplier
        }
        else {
            [int]$value = $line.split('addx ')[1] 
            for ($i = 0; $i -lt 2; $i++) {
                $Global:cycleCounter ++
                Invoke-XMultiplier
            }

        }
        $Global:XValue += $value
    }
}
foreach ($line in $stuff) {
    Process-Stuffline -line $line
}
$sum = 0
$strengtharray.foreach({$sum += $_})
$sum

# task 2