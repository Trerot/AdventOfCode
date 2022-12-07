$filestuff = get-content "C:\Users\david\REPOS\AdventOfCode2022\day7\AOC2022day7-puzzleinput.txt"
$stuff = $filestuff
$linenumber = 0
$Global:currentdir = "root"
$thingarray = New-Object -TypeName System.Collections.ArrayList
$folderarray = New-Object -TypeName System.Collections.ArrayList

# function for the CD commands
function Invoke-PuzzleCD {
    param (
        [string]$command
    )
    switch ($command) {
        "$ cd /" {
            $Global:currentdir = "root"
        }
        "$ cd .." { 
            $last = $Global:currentdir.LastIndexOf('/')
            $Global:currentdir = $Global:currentdir.Substring(0, $last)
        }
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
# function for the LS commands
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
#create thingarray, which consists, of folder contents + folder path
foreach ($item in $stuff) {
    switch -wildcard ($item) {
        "$ ls" {
            [void]$thingarray.Add([PSCustomObject]@{
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

$NewThingarray = New-Object -TypeName System.Collections.ArrayList
# find the filesizetotal for all folders, ignore all dirs, just focus on the files and create a list with path,filesizetotal,content
foreach ($thing in $thingarray) {
    $value = 0
    $thing.content.foreach({
            if ($_ -like 'dir*') {}
            else { $value += [int]($_.split(' ')[0]) }
        })
    [void]$NewThingarray.add(
        [PSCustomObject]@{
            dir           = $thing.dir
            content       = $thing.content
            filesizetotal = $value
        })
}
$LastThingarray = New-Object -TypeName System.Collections.ArrayList
# loop trough $newthingarray and add the filesize totals of all paths  that inscude its own path.
foreach ($thing in $NewThingarray) {
    $value = 0
    $NewThingarray.where({ $_.dir -like "$($thing.dir)*" }).filesizetotal.foreach({ $value += $_ })
    [void]$LastThingarray.Add([PSCustomObject]@{
            FolderTotal   = $value
            foldername    = $thing.dir
            content       = $thing.content
            filesizetotal = [int]$thing.filesizetotal
        })
}
$sum = 0
$LastThingarray.where({$_.FolderTotal -lt 100000}).FolderTotal.foreach({$sum += $_})
# answer 1
$sum
# task 2
$totaldiskspace = 70000000
$spacerequired = 30000000
$spaceused = $LastThingarray[0].FolderTotal
$freespace = $totaldiskspace-$spaceused
$spacetofree =  $spacerequired-$freespace
($LastThingarray.FolderTotal | sort).where({$_ -gt $spacetofree})[0]