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

($arraylist | Group-Object | where-object { $_.name -like "t*"}).count