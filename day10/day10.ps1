$stuff = get-content .\day10\input.txt
#$stuff = get-content .\day10\sample.txt

$Global:cycleCounter = 0
$Global:XValue = 1
$Global:SpriteRange = 0,1,2
$Global:multiCycle = 20
$Global:StrengthArray = New-Object -TypeName System.Collections.ArrayList
$Global:CRTArray = New-Object -TypeName System.Collections.ArrayList
$Global:CRTLine = $null

function Invoke-XMultiplier {
    if ($Global:cycleCounter -eq $Global:multiCycle) {
        $strength = $Global:XValue * $Global:multiCycle
        [void]$Global:StrengthArray.add($strength)
        $Global:multiCycle += 40
    }
    
}
function Invoke-NewCRTLine {

    process {
        if ($Global:CRTLine.Length -eq 40) {
            $Global:CRTArray.add($Global:CRTLine)
            $Global:CRTLine = $null
        }
    }
}
function Invoke-CRTPixel {
    process {
        $linenum = $Global:CRTLine.Length
        if ($Global:SpriteRange -contains $linenum) { $Global:CRTLine += "#" }
        elseif ($Global:SpriteRange -notcontains $linenum) {
            $Global:CRTLine += "." 
        }
        else { "this should not happen." }
    } 
}


# the loop.
foreach ($line in $stuff) {
    if ($line -eq "noop") {
        $value = $null

        $Global:cycleCounter ++
        Invoke-XMultiplier
        $Global:SpriteRange = ($Global:XValue - 1),$Global:XValue,($Global:XValue + 1)
        Invoke-NewCRTLine
        Invoke-CRTPixel
    }
    else {
        [int]$value = $line.split('addx ')[1] 
        for ($i = 0; $i -lt 2; $i++) {
            $Global:cycleCounter ++
            Invoke-XMultiplier
            $Global:SpriteRange = ($Global:XValue - 1)..($Global:XValue + 1)
            Invoke-NewCRTLine
            Invoke-CRTPixel
        }
    }
    $Global:XValue += $value
        
}

$sum = 0
$strengtharray.foreach({ $sum += $_ })
$sum

$CRTArray
$CRTLine



