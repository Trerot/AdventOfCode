$stuff = get-content "day5\AOC2022da5-puzzleinput.txt"
$stack = $stuff[0..7]
$instructionset = $stuff[10..($stuff.count - 1)]
function Remove-Block {
    [CmdletBinding()]
    param (
        $movefrom
    )
    process {
        switch ($movefrom) {
            1 { if ($Global:one.count -gt 0) { $Global:one.RemoveAt($($Global:one.count - 1)) } }
            2 { if ($Global:two.count -gt 0) { $Global:two.RemoveAt($($Global:two.count - 1)) } }
            3 { if ($Global:three.count -gt 0) { $Global:three.RemoveAt($($Global:three.count - 1)) } }
            4 { if ($Global:four.count -gt 0) { $Global:four.RemoveAt($($Global:four.count - 1)) } }
            5 { if ($Global:five.count -gt 0) { $Global:five.RemoveAt($($Global:five.count - 1)) } }
            6 { if ($Global:six.count -gt 0) { $Global:six.RemoveAt($($Global:six.count - 1)) } }
            7 { if ($Global:seven.count -gt 0) { $Global:seven.RemoveAt($($Global:seven.count - 1)) } }
            8 { if ($Global:eight.count -gt 0) { $Global:eight.RemoveAt($($Global:eight.count - 1)) } }
            9 { if ($Global:nine.count -gt 0) { $Global:nine.RemoveAt($($Global:nine.count - 1)) } }
            10 { if ($Global:ten.count -gt 0) { $Global:ten.RemoveAt($($Global:ten.count - 1)) } }
        }
    }
}
function Add-Block {
    [CmdletBinding()]
    param (
        $moveto,
        $blockvalue
    )
    process {
        switch ($moveto) {
            1 { [void]$Global:one.add($blockvalue) }
            2 { [void]$Global:two.add($blockvalue) }
            3 { [void]$Global:three.add($blockvalue) }
            4 { [void]$Global:four.add($blockvalue) }
            5 { [void]$Global:five.add($blockvalue) }
            6 { [void]$Global:six.add($blockvalue) }
            7 { [void]$Global:seven.add($blockvalue) }
            8 { [void]$Global:eight.add($blockvalue) }
            9 { [void]$Global:nine.add($blockvalue) }
            10 { [void]$Global:ten.add($blockvalue) }
        }
    }
}
function Move-Block {
    [CmdletBinding()]
    param (
        $movefrom,
        $moveto
    )
    process {
        #need to get block value.
        $blockvalue = switch ($movefrom) {
            1 { $Global:one[-1] }
            2 { $Global:two[-1] }
            3 { $Global:three[-1] }
            4 { $Global:four[-1] }
            5 { $Global:five[-1] }
            6 { $Global:six[-1] }
            7 { $Global:seven[-1] }
            8 { $Global:eight[-1] }
            9 { $Global:nine[-1] }
            10 { $Global:ten[-1] }
        }
        Remove-Block -movefrom $movefrom
        Add-Block -moveto $moveto -blockvalue $blockvalue
    }
}
function Invoke-Instructionset {
    [CmdletBinding()]
    param (
        $instructionset,
        [int32]$tasknumber
    )
    begin {
        $Global:one = New-Object -TypeName System.Collections.ArrayList
        $Global:two = New-Object -TypeName System.Collections.ArrayList
        $Global:three = New-Object -TypeName System.Collections.ArrayList
        $Global:four = New-Object -TypeName System.Collections.ArrayList
        $Global:five = New-Object -TypeName System.Collections.ArrayList
        $Global:six = New-Object -TypeName System.Collections.ArrayList
        $Global:seven = New-Object -TypeName System.Collections.ArrayList
        $Global:eight = New-Object -TypeName System.Collections.ArrayList
        $Global:nine = New-Object -TypeName System.Collections.ArrayList
        $Global:ten = New-Object -TypeName System.Collections.ArrayList
        for ($i = 7; $i -ge 0; $i += -1) {
            $stack[$i].ForEach({
                    if ($_[1] -ne " ") { [void]$Global:one.add([char]$_[1]) }
                    if ($_[5] -ne " ") { [void]$Global:two.add([char]$_[5]) }
                    if ($_[9] -ne " ") { [void]$Global:three.add([char]$_[9]) }
                    if ($_[13] -ne " ") { [void]$Global:four.add([char]$_[13]) }
                    if ($_[17] -ne " ") { [void]$Global:five.add([char]$_[17]) }
                    if ($_[21] -ne " ") { [void]$Global:six.add([char]$_[21]) }
                    if ($_[25] -ne " ") { [void]$Global:seven.add([char]$_[25]) }
                    if ($_[29] -ne " ") { [void]$Global:eight.add([char]$_[29]) }
                    if ($_[33] -ne " ") { [void]$Global:nine.add([char]$_[33]) }                          
                })
        }
    }
    process {
        $instructionset.foreach({
                $null, [int]$moveamount, $null, [int]$movefrom, $null, [int]$moveto = $_.split(" ")
                $firstmove = $moveamount
                $secondmove = $moveamount
                switch ($tasknumber) {
                    1 { 
                        while ($moveamount -gt 0) {
                            Move-Block -movefrom $movefrom -moveto $moveto
                            $moveamount = $moveamount - 1
                        } 
                    }
                    2 {
                        while ($firstmove -gt 0) {

                            Move-Block -movefrom $movefrom -moveto 10
                            $firstmove = $firstmove - 1
                        } 
                        while ($secondmove -gt 0) {
                            Move-Block -movefrom 10 -moveto $moveto
                            $secondmove = $secondmove - 1
                        }  
                    }
                }
            })
    }
    end {
        $one[-1] + $two[-1] + $three[-1] + $four[-1] + $five[-1] + $six[-1] + $seven[-1] + $eight[-1] + $nine[-1]    
    }
}
Invoke-Instructionset -tasknumber 1 -instructionset $instructionset
Invoke-Instructionset -tasknumber 2 -instructionset $instructionset