$stuff = get-content 'C:\Users\david\REPOS\AdventOfCode2022\day9\mediumsampleset.txt'
$Global:SnakeMovesArray = New-Object -TypeName System.Collections.ArrayList
$Global:previous = 0
#creating the snake a..j which is 10 elements, so head is a, tail is j
$Global:hashtable = @{}
('a'..'j').foreach({ $Global:hashtable.Add("$_", @(0, 0)) })

#this function moves the head, and at the end it runs move-t which moves the tail.
function Move-H {
    param (
        $item,
        [switch]$moveT,
        [int]$task
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

        #just to quickly change task
        if ($task -eq 1) {
            $set = 'b'
        }
        if ($task -eq 2) {
            $set = 'b'..'j'
        }
        if ($moveT) {
            # now to move the snake
            $Global:previous = 'a'
            $set.ForEach({ Move-T -snakeletter $_ })  
        }
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
        '-1,2' { $X--; $Y++ }
        '0,-2' { $Y-- }
        '0,2' { $Y++ }
        '1,-2' { $X++; $Y-- }
        '1,2' { $X++; $Y++ }
        '2,-1' { $X++; $Y-- }
        '2,0' { $X++ }
        '2,1' { $X++; $Y++ }
    }
    
    $Global:hashtable."$snakeletter"[0] += $X
    $Global:hashtable."$snakeletter"[1] += $Y

    $snakestring = "$snakeletter,$($Global:hashtable."$snakeletter"[0]),$($Global:hashtable."$snakeletter"[1])"
    [void]$Global:SnakeMovesArray.add($snakestring)
    $Global:previous = $snakeletter
}

#this is the main loop
# -movet is a switch, remove it and it only moves head
# -task  takes 1 or 2, it changes the length of snake from just Head and tail(task 1) to 10 thingies(task 2)
foreach ($line in $stuff) {
    Move-H -item $line -task 2 -moveT
}
$hashtable

($SnakeMovesArray | Group-Object | where-object { $_.name -like "j*" }).count