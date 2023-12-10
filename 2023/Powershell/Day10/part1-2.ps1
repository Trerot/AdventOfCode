$stuff = Get-Content .\2023\Powershell\Day10\puzzleinput.txt
$xedge= $stuff[0].Length +1
$yedge = $stuff.count +1
"building char map"
$charmap = @{
    '|' = 'up', 'down'
    '-' = 'left', 'right'
    'L' = 'up', 'right'
    'J' = 'up', 'left'
    '7' = 'down', 'left'
    'F' = 'right', 'down'
    '.' = 'wall'
    'S' = 'start'
}
"done"
"building hashmap"
$HashMap = @{}
for ($y = 0; $y -lt $stuff.Count; $y++) {
    # now i have a y line conter, just need an x counter and start population
    for ($x = 0; $x -lt $stuff.Length; $x++) {
        #building the hashmap
        $HashMap."$x,$y" = $charmap.[string]$stuff[$y][$x]
        #finding starting position
        if ($stuff[$x][$y] -eq 'S') {
            $StartX = $y
            $StartY = $x
        }
    }
}
"done"
$start = "$startx,$starty"
"S found at $start"
$x = $StartX
$y = $starty

function Move-Thing {
    param (
        $direction,
        $x,
        $y
    )

    switch ($direction) {
        'up' { $y += -1 }
        'down' { $y += 1 }
        'left' { $x += -1 }
        'right' { $x += 1 }
        Default {}
    }
    $x
    $y
}
function Get-ConnectionThing {
    param (
        $direction
    )
    switch ($direction) {
        'up' { 'down' }
        'down' { 'up' }
        'left' { 'right' }
        'right' { 'left' }
        Default {}
    }
}
# testing all 4 possible paths from start
$x2 = 0
$y2= 0
foreach ($direction in ('up', 'down', 'left', 'right')) {
    write-host "----------------moving $direction---------------------"
    $initdirection = $direction
    $x2, $y2 = Move-Thing -direction $direction -x $x -y $y
    $Currentchar = $HashMap."$x2,$y2"
    $continue = $true
    $counter = 0
    while ($continue) {
        if ($x2 -eq '-1' -or $y2 -eq '-1' -or $x2 -eq $xedge -or $y2 -eq $yedge) { 
            write-host "Out of Bonds! x$x2 or y$y2 is either negaitve or at $yedge"
            write-host "counter stopped at $counter"
            
            $continue = $false
        }
        else {
            switch ($Currentchar) {
                'wall' {      
                    $counter      
                    $continue = $false 
                }
                'start' {
                    [Math]::Ceiling($counter/2)
                    $continue = $false
                }
                Default {
                    $connection = Get-ConnectionThing -direction $direction
                    if ($currentChar -contains $connection) {
                        #its a valid move.
                        $direction = $currentChar.where({ $_ -ne $connection })
                        $x2, $y2 = Move-Thing -direction $direction -x $x2 -y $y2
                        $counter++
                        $Currentchar = $HashMap."$x2,$y2"
                    }
                    else {
                        #apparently this is the S spot now if count is greater than 0
                        if($counter -gt 0){
                            write-host "i think you hit start again"
                            [Math]::Ceiling($counter/2)
                            $continue = $false
                            $counter = 0
                        }
                        else {
                            write-host "crashed into something, break at $x2,$y2 for $initdirection"
                            $continue = $false
                            $counter = 0
                        }
                    }
                }
            }
        }
    }

}
# testinput 1 should be 4
# testinput 2 should be 8
# puzzle input 13379 is to high