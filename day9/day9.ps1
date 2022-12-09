$stuff = get-content "C:\Users\davhei15\repos\AdventOfCode2022\day9\sampleset.txt"
$Arraylist = New-Object -TypeName System.Collections.ArrayList


[global]$H = 'H', 0, 0
[global]$T = 'T', 0, 0
# $H[1] $T[1] is X
# $H[2] $T[2] is Y

[void][global]$Arraylist.add( "$($H[0]),$($H[1]),$($H[2])")
[void][global]$Arraylist.add( "$($T[0]),$($T[1]),$($T[2])")

foreach ($item in $stuff) {
    [char]$Direction, [int]$Distance = $item.split(" ")
    #this moves the H around
    switch ($Direction) {
        "U" { $Y += $Distance }
        "D" { $Y -= $Distance }
        "R" { $X += $Distance }
        "L" { $X -= $Distance }
    }
    [global]$H[1] = $X
    [global]$H[2] = $Y
    [void]$Arraylist.add( "$($H[0]),$($H[1]),$($H[2])")
    # now i need to move the tail based on H pos



}


function Move-H {
    param (
        [int]$H,
        [char]$Direction,
        [int]$Distance
    )
    for ($i = 0; $i -lt $Distance; $i++) {
        switch ($Direction) {
            "R" { [global]$H[1] ++ }
            "L" { [global]$H[1] -- }
            "U" { [global]$H[2] ++ }
            "D" { [global]$H[2] -- }
        }
        [void][global]$Arraylist.add( "$($H[0]),$($H[1]),$($H[2])")
    }
}

function Move-T {
    param (
        $H = [global]$H,
        $T = [global]$T
    )
    $X = 0
    $Y = 0
    # for the x axis
    if ($H[1] - $T[1] -gt 1) { $X ++ }
    if ($H[1] - $T[1] -lt -1) { $X -- }
    # for the y
    if ($H[2] - $T[2] -gt 1 ) { $Y ++ }
    if ($H[2] - $T[2] -lt -1) { $Y -- }

    # but they should add upp to something. instead of plussing the $T they should pluss the X and Y. and if X and Y are both 1 or -1 then move diag.

    # define the four diagonal moves.
    # up right(+ +)
    if ($X + $Y -eq 2) {}
    # up left(+ -)
    if ($X -eq 1 -and $Y -eq -1) {}
    # down right(- +)
    if ($X -eq -1 -and $Y -eq 1) {}
    # down left (- -)
    if (-$X - $Y -eq -2) {}

    # define the for straight moves
    #up
    if ($X -eq 0 -and $Y -eq 1 ) {}
    #down
    if ($X -eq 0 -and $Y -eq -1 ) {}
    #right
    if ($X -eq 1 -and $Y -eq 0 ) {}
    #left 
    if ($X -eq -1 -and $Y -eq 0 ) {}


    [void]$Arraylist.add( "$($T[0]),$($T[1]),$($T[2])")
}
