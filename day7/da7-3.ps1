$stuff = get-content "C:\Users\david\REPOS\AdventOfCode2022\day7\AOC2022day7-puzzleinput.txt"
$linenumber = 0
$Global:currentdir = "root"
$thingarray = New-Object -TypeName System.Collections.ArrayList
$folderarray = New-Object -TypeName System.Collections.ArrayList

function Invoke-PuzzleCD {
    param (
        [string]$command
    )
    switch ($command) {
        "$ cd /" {
            $Global:currentdir = "root"
        }
        "$ cd .." { $Global:currentdir = -join $Global:currentdir[0..($Global:currentdir.Length - 3)] }
        default { 
            $dirname = ($command -split " ")[2]
            $Global:currentdir = $Global:currentdir + "/" + $dirname 
            [void]$Global:folderarray.add(
                [PSCustomObject]@{
                    dirname    = $dirname
                    linenumber = $linenumber
                })
        }
    }
}
function Invoke-PuzzleLS {
    param (
        [int]$linenumber
    )
    #should get everything from the LS line to the next $ command
    for ($i = $linenumber + 1; $i -lt $stuff.Count; $i++) {
        if ($stuff[$i] -notlike '$*') {
            $stuff[$i]
        }
        else { break }
    }
}

foreach ($item in $stuff) {
    switch -wildcard ($item) {
        "$ ls" {
            $thingarray.Add([PSCustomObject]@{
                    dir     = $currentdir
                    content = Invoke-PuzzleLS -linenumber $linenumber
                }
            ) 
        }
        "$ c*" { Invoke-PuzzleCD -command $item }
        Default {}
    }
    $linenumber ++
}

# now in my $thingarray, 