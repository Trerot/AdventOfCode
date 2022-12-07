#$stuff = get-content "C:\Users\davhei15\repos\AdventOfCode2022\day7\AOC2022day6-puzzleinput.txt"
#$stuff = get-clipboard
$keep # contains get-clipboard stuff
[int]$indexnum = 0

$arraylist = New-Object -TypeName System.Collections.ArrayList
$hashtable = @{}
$hashtable2 = @{}
function Invoke-PuzzleCommand {
    param (
        [string]$command
    )
    switch ($command) {
        "$ cd /" {
            $Global:currentdir = "root"
        }
        "$ cd .." { $Global:currentdir = -join $Global:currentdir[0..($Global:currentdir.Length - 3)] }
        "$ ls" { <#do nothing#> }
        default { 
            $Global:dirname = ($command -split " ")[2]
            $Global:currentdir = $Global:currentdir + "/" + $dirname 
        }
    }
}
foreach ($item in $stuff) {
    switch -wildcard ($item) {
        "$*" { Invoke-PuzzleCommand $item }
        "dir*" {}
        default {
            [int]$value, [string]$name = $item.split(" ")
            if ($null -eq $hashtable.$Global:currentdir) {
                
                $object = ([PSCustomObject]@{
                        name       = $Global:currentdir
                        dirname    = $Global:dirname
                        value      = $value
                        indexnum   = $indexnum
                        totalvalue = 0
                    })
                    [void]$arraylist.add($object)
                    $hashtable.add($Global:currentdir, $value)
                    $hashtable2.add($Global:currentdir, $object)
                $indexnum  ++
            }
            else { 
                $hashtable.($Global:currentdir) += $value
                $arraylist[$arraylist.where({ $Global:currentdir -eq $_.name }).indexnum].value += $value
            }
        }
    }
}
($arraylist).foreach({
        $item = $_
        $dirsum = 0
        $selection = $arraylist.where({ $_.name -like "$($item.name)*" })
        $selection.foreach({ $dirsum += $_.value })
        $arraylist[$item.indexnum].totalvalue = $dirsum
    })
[int]$sum = 0
$arraylist.where({ $_.totalvalue -lt 100000 }).foreach({ $sum += $_.totalvalue })
"# previous wrongs"
1482845
994905
"----- possible answer---------"
$sum