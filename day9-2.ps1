#each move of each knot is stored in $snakemovesarray
#current position of each snake is stored in $hashtable

$stuff = get-content 'C:\Users\david\REPOS\AdventOfCode2022\day9\puzzleinput.txt'
$Global:SnakeMovesArray = New-Object -TypeName System.Collections.ArrayList
$Global:previous = 0
#creating the snake a..j which is 10 elements, so head is a, tail is j
$Global:hashtable = @{}
#population hashtable with 10 knots, key is letter, value is an array with 2 ints. first is x, second is y
('a'..'j').foreach({ $Global:hashtable.Add("$_", @(0, 0)) })

#moves the head
foreach ($line in $stuff) {
    [char]$Direction, [int]$Distance = $line.split(" ")

    for ($i = 0; $i -lt $Distance; $i++) {
        switch ($Direction) {
            "R" { $Global:hashtable.'a'[0] ++ }
            "L" { $Global:hashtable.'a'[0]  -- }
            "U" { $Global:hashtable.'a'[1]  ++ }
            "D" { $Global:hashtable.'a'[1]  -- }
        }
        [void]$Global:SnakeMovesArray.add( "a,$($Global:hashtable.a[0]),$($Global:hashtable.a[1])")
        # now to move the tail ends
        $Global:previous = 'a'

 ('b'..'j').ForEach({
                $XString = [string]($Global:hashtable."$Global:previous"[0] - $Global:hashtable."$_"[0])
                $YString = [string]($Global:hashtable."$Global:previous"[1] - $Global:hashtable."$_"[1])
                $X = 0
                $Y = 0

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
                $Global:hashtable."$_"[0] += $X
                $Global:hashtable."$_"[1] += $Y
                $snakestring = "$_,$($Global:hashtable."$_"[0]),$($Global:hashtable."$_"[1])"
                [void]$Global:SnakeMovesArray.add($snakestring)
                $Global:previous = $_
            })  
    }
}
#task 1 answer
($SnakeMovesArray | Group-Object | where-object { $_.name -like "b*" }).count
# task 2 answer
($SnakeMovesArray | Group-Object | where-object { $_.name -like "j*" }).count

# take a look at $hashtable to see my issue,  also present in the list containing moves