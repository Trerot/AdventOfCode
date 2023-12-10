$stuff = Get-Content .\2023\Powershell\Day10\testinput2.txt
<# 
| is a vertical pipe connecting north and south.
- is a horizontal pipe connecting east and west.
L is a 90-degree bend connecting north and east.
J is a 90-degree bend connecting north and west.
7 is a 90-degree bend connecting south and west.
F is a 90-degree bend connecting south and east.
. is ground; there is no pipe in this tile.
S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
 #>
$left = '-1,0'
$right = '1,0'
$up = '0,-1'
$down = '0,1'
$PossibleWays = $left, $right, $up, $down
# charmap
$CharMap = @{
    
    '|' = [PSCustomObject]@{ 
    } 
    '-' = [PSCustomObject]@{
        x = 1, -1
        y = 0
    } 
    'L' = [PSCustomObject]@{
        x = 1
        y = -1
    } 
    'J' = [PSCustomObject]@{
        x = -1
        y = -1
    } 
    '7' = [PSCustomObject]@{
        x = -1
        y = 1
    } 
    'F' = [PSCustomObject]@{
        x = 1
        y = 1
    } 
    '.' = [PSCustomObject]@{
        x = 0
        y = 0
    } 
    'S' = [PSCustomObject]@{
        x = 'start'
        y = 'start'
    }     
}
$charmap2 = @{
    '|' = $up, $down
    '-' = $left, $right
    'L' = $up, $right
    'J' = $up, $left
    '7' = $down, $left
    'F' = $right, $down
    '.' = 'wall'
    'S' = 'start'
}
#create an xy hashmap of this map
$HashMap = @{}
for ($y = 0; $y -lt $stuff.Count; $y++) {
    # now i have a y line conter, just need an x counter and start population
    for ($x = 0; $x -lt $stuff.Length; $x++) {
        #building the hashmap
        $HashMap."$x,$y" = $stuff[$y][$x]
        #finding starting position
        if ($stuff[$x][$y] -eq 'S') {
            $StartX = $x
            $StartY = $y
        }
    }
}

$spentHash = @{}

$spentHash.Add("$startX,$startY", $true)


$continue = $true
$positioncounter = 0
$positioncounterarray = New-Object -TypeName System.Collections.ArrayList

function DoTheThing {
    param (
        #position is x,y string
        $position,
        $nextPosition,
        $counter
    )
    $posxy = $position -split ','
    $nextposxy = $nextposition -split ','
    $positiondiff = "$([int]$posxy[0]-[int]$nextposxy[0]),$([int]$posxy[1]-[int]$nextposxy[1])"
    $positionChar = $HashMap.$position
    $nextPositionChar = $HashMap.$nextPosition


    switch ($nextPositionChar) {
        's' {
            $counter++
            $object = [PSCustomObject]@{
                Continue     = $false
                position     = $position
                counter      = [math]::Floor($counter / 2)
                nextposition = $false
            }
        }
        '.' {
            $object = [PSCustomObject]@{
                Continue     = $false
                position     = $position
                counter      = $counter
                nextposition = $false
            }
        }
        Default {
            if ($positiondiff -in $charmap2."$nextPositionChar") {
                $counter++
                $AddToNext = ($charmap2."$nextPositionChar").where({
                        $_ -notin $positiondiff
                    }) -split ','
                $NextEnd = "$([int]$nextposxy[0] + [int]$AddToNext[0]),$([int]$nextposxy[1] + [int]$AddToNext[1])"


                $object = [PSCustomObject]@{
                    Continue     = $true
                    position     = $nextPosition
                    counter      = $counter
                    nextposition = [string]$nextend
                }
            }
        }
    }
    $object
}

#if valid move, do the move, then shove out the next position and position counter



$start = "$startx,$starty"
$position = $start
$possiblestarts = "$($startx+1),$starty", "$($startx-1),$starty", "$startx,$($starty+1)", "$startx,$($starty-1)"
$continue = $true
$counter = 0
$startObject = [PSCustomObject]@{
    Continue     = $true
    position     = $position
    counter      = 0
    nextposition = $false
}
# for the start, consider possible ways
foreach ($way in $possiblestarts) {
    $thing = [PSCustomObject]@{
        Continue     = $true
        position     = $position
        counter      = 0
        nextposition = $way
    }
    while ($thing.Continue) {
        $thing = DoTheThing -position $thing.position -nextPosition $thing.nextposition -counter $thing.counter
        $thing
    }
    'this is for way ' + $way
    $thing.counter
}


#simple should be 4
# complex should be 8