$stuff = get-content "day5\AOC2022da5-puzzleinput.txt"

# doing it the dumb way for now
$stack = $stuff[0..7]
$instructionset = $stuff[10..($stuff.count - 1)]


# stacked arrays
$Global:one = New-Object -TypeName System.Collections.ArrayList
$Global:two = New-Object -TypeName System.Collections.ArrayList
$Global:three = New-Object -TypeName System.Collections.ArrayList
$Global:four = New-Object -TypeName System.Collections.ArrayList
$Global:five = New-Object -TypeName System.Collections.ArrayList
$Global:six = New-Object -TypeName System.Collections.ArrayList
$Global:seven = New-Object -TypeName System.Collections.ArrayList
$Global:eight = New-Object -TypeName System.Collections.ArrayList
$Global:nine = New-Object -TypeName System.Collections.ArrayList

#adding to stack in reverse
for ($i = 7; $i -ge 0; $i += -1) {
    $stack[$i].ForEach({
            # [1, 5, 9, 13, 17, 21, 25, 29, 33]
            if ($_[1] -ne " ") { [void]$one.add([char]$_[1]) }
            if ($_[5] -ne " ") { [void]$two.add([char]$_[5]) }
            if ($_[9] -ne " ") { [void]$three.add([char]$_[9]) }
            if ($_[13] -ne " ") { [void]$four.add([char]$_[13]) }
            if ($_[17] -ne " ") { [void]$five.add([char]$_[17]) }
            if ($_[21] -ne " ") { [void]$six.add([char]$_[21]) }
            if ($_[25] -ne " ") { [void]$seven.add([char]$_[25]) }
            if ($_[29] -ne " ") { [void]$eight.add([char]$_[29]) }
            if ($_[33] -ne " ") { [void]$nine.add([char]$_[33]) }                          
        })
}

function Remove-Block {
    [CmdletBinding()]
    param (
        $RemoveFrom
    )
    process {
        switch ($RemoveFrom) {
            1 { $Global:one.RemoveAt($($Global:one.count - 1)) }
            2 { $Global:two.RemoveAt($($Global:two.count - 1)) }
            3 { $Global:three.RemoveAt($($Global:three.count - 1)) }
            4 { $Global:four.RemoveAt($($Global:four.count - 1)) }
            5 { $Global:five.RemoveAt($($Global:five.count - 1)) }
            6 { $Global:six.RemoveAt($($Global:six.count - 1)) }
            7 { $Global:seven.RemoveAt($($Global:seven.count - 1)) }
            8 { $Global:eight.RemoveAt($($Global:eight.count - 1)) }
            9 { $Global:nine.RemoveAt($($Global:nine.count - 1)) }
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
            1 { $Global:one.add($blockvalue) }
            2 { $Global:two.add($blockvalue) }
            3 { $Global:three.add($blockvalue) }
            4 { $Global:four.add($blockvalue) }
            5 { $Global:five.add($blockvalue) }
            6 { $Global:six.add($blockvalue) }
            7 { $Global:seven.add($blockvalue) }
            8 { $Global:eight.add($blockvalue) }
            9 { $Global:nine.add($blockvalue) }
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
        }
        Remove-Block -RemoveFrom $RemoveFrom
        Add-Block -moveto $moveto -blockvalue $blockvalue
    }
}
$instructionset[0..10].foreach({
        $null, [int]$moveamount, $null, [int]$movefrom, $null, [int]$moveto = $instructionset[0].split(" ")
        for ($moveamount -gt 0; $moveamount += -1) {

        }
    })

