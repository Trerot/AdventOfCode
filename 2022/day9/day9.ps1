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
$Global:hashtable = @{}
('a'..'j').foreach({ $Global:hashtable.Add("$_", @(1, 0)) })

function Move-H {
    param (
        $item
    )
    [char]$Direction, [int]$Distance = $item.split(" ")
    for ($i = 0; $i -lt $Distance; $i++) {
        switch ($Direction) {
            "R" { $Global:hashtable.'a'[0] ++ }
            "L" { $Global:hashtable.'a'[0]  -- }
            "U" { $Global:hashtable.'a'[1]  ++ }
            "D" { $Global:hashtable.'a'[1]  -- }
        }
        [void]$Global:SnakeMovesArray.add( "a,$($Global:hashtable.a[0]),$($Global:hashtable.a[1])")
        # now to move the snake
        $Global:previous = 'a'
        ('b'..'j').ForEach({ Move-T -snakeletter $_ })  
    }
}
function Move-T {
    param (
        $snakeletter
    )
    $X = 0
    $Y = 0
    $XString = [string]($Global:hashtable."$Global:previous"[0] - $Global:hashtable."$snakeletter"[0])
    $YString = [string]($Global:hashtable."$Global:previous"[1] - $Global:hashtable."$snakeletter"[1])

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
    
    $Global:hashtable."$snakeletter"[0] += $X
    $Global:hashtable."$snakeletter"[1] += $Y

    $snakestring = "$snakeletter,$($Global:hashtable."$snakeletter"[0]),$($Global:hashtable."$snakeletter"[1])"
    [void]$Global:SnakeMovesArray.add( $snakestring)
    $Global:previous = $snakeletter
}


foreach ($line in $stuff) {
    Move-H -item $line
}
