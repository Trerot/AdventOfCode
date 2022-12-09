$stuff = get-content "C:\Users\david\REPOS\AdventOfCode2022\day9\puzzleinput.txt"
$Arraylist = New-Object -TypeName System.Collections.ArrayList

$Global:H = 'H', 0, 0
$Global:T = 'T', 0, 0
# $H[1] $T[1] is X
# $H[2] $T[2] is Y
[void]$Global:Arraylist.add( "$($H[0]),$($H[1]),$($H[2])")
[void]$Global:Arraylist.add( "$($T[0]),$($T[1]),$($T[2])")
function Move-H {
    param (
        $item
    )
    [char]$Direction, [int]$Distance = $item.split(" ")
    for ($i = 0; $i -lt $Distance; $i++) {
        switch ($Direction) {
            "R" { $Global:H[1] ++ }
            "L" { $Global:H[1] -- }
            "U" { $Global:H[2] ++ }
            "D" { $Global:H[2] -- }
        }
        [void]$Global:Arraylist.add( "$($Global:H[0]),$($Global:H[1]),$($Global:H[2])")
        Move-T
    }
}
function Move-T {
    param (
    )
    $X = 0
    $Y = 0

    switch (([string]($H[1] - $T[1]) + ',' + [string]($H[2] - $T[2]))) {
        '-2,-1' { $X--; $Y-- }
        '-2,0' { $X-- }
        '-2,1' { $X--; $Y++ }
        '-1,-2' { $X--; $Y-- }
        '-1,-1' {  }
        '-1,0' {  }
        '-1,1' {  }
        '-1,2' { $X--; $Y++ }
        '0,-2' { $Y-- }
        '0,-1' {  }
        '0,0' {  }
        '0,1' {  }
        '0,2' { $Y++ }
        '1,-2' { $X++; $Y-- }
        '1,-1' {  }
        '1,0' {  }
        '1,1' {  }
        '1,2' { $X++; $Y++ }
        '2,-1' { $X++; $Y-- }
        '2,0' { $X++ }
        '2,1' { $X++; $Y++ }
    }
    
    $Global:T[1] += $X
    $Global:T[2] += $Y
    [void]$Arraylist.add( "$($Global:T[0]),$($Global:T[1]),$($Global:T[2])")
}
foreach ($line in $stuff) {
    Move-H -item $line
}
#answer prints here
($arraylist | Group-Object | where-object { $_.name -like "t*" }).count


# Task 2
$stuff = get-content 'C:\Users\david\REPOS\AdventOfCode2022\day9\mediumsampleset.txt'
$Global:SnakeArray = New-Object -TypeName System.Collections.ArrayList
$Global:SnakeMovesArray = New-Object -TypeName System.Collections.ArrayList
$Global:previous = 0
#creating the snake
(0..9).foreach({
        [void]$Global:SnakeArray.add(@(0, 0))
    }) 


function Move-H {
    param (
        $item
    )
    [char]$Direction, [int]$Distance = $item.split(" ")
    for ($i = 0; $i -lt $Distance; $i++) {
        switch ($Direction) {
            "R" { $Global:SnakeArray[0][0] ++ }
            "L" { $Global:SnakeArray[0][0] -- }
            "U" { $Global:SnakeArray[0][1] ++ }
            "D" { $Global:SnakeArray[0][1] -- }
        }
        [void]$Global:SnakeMovesArray.add( "0,$($Global:SnakeArray[0][0]),$($Global:SnakeArray[0][1])")
        # snake stuff
        # now to move the knots.
        $Global:previous = 0
        for ($j = 1; $j -lt $Global:SnakeArray.Count; $j++) {
            Move-T -snakenumber $j
        }
    }
}
function Move-T {
    param (
        [int]$snakenumber
    )
    $X = 0
    $Y = 0
    $XString = [string]($Global:SnakeArray[$Global:previous][0] - $Global:SnakeArray[$snakenumber][0])
    $YString = [string]($Global:SnakeArray[$Global:previous][1] - $Global:SnakeArray[$snakenumber][1])

    switch (($XString + ',' + $YString)) {
        '-2,-1' { $X--; $Y-- }
        '-2,0' { $X-- }
        '-2,1' { $X--; $Y++ }
        '-1,-2' { $X--; $Y-- }
        '-1,-1' {  }
        '-1,0' {  }
        '-1,1' {  }
        '-1,2' { $X--; $Y++ }
        '0,-2' { $Y-- }
        '0,-1' {  }
        '0,0' {  }
        '0,1' {  }
        '0,2' { $Y++ }
        '1,-2' { $X++; $Y-- }
        '1,-1' {  }
        '1,0' {  }
        '1,1' {  }
        '1,2' { $X++; $Y++ }
        '2,-1' { $X++; $Y-- }
        '2,0' { $X++ }
        '2,1' { $X++; $Y++ }
    }
    
    $Global:SnakeArray[$snakenumber][0] += $X
    $Global:SnakeArray[$snakenumber][1] += $Y
    
    $Global:SnakeMovesArray.add( "$snakenumber,$($Global:SnakeArray[$snakenumber][0]),$($Global:SnakeArray[$snakenumber][1])")
    $Global:previous = $snakenumber
}


foreach ($line in $stuff) {
    Move-H -item $line
}
