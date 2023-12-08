$stuff = get-content .\2023\Powershell\Day8\puzzleinput.txt
$aNodes = New-Object -TypeName System.Collections.ArrayList
$zNodes = New-Object -TypeName System.Collections.ArrayList
$lrmoves = $stuff[0].ToCharArray()
$ElementHash = @{}
foreach ($element in $stuff[2..($stuff.count)]) {
    $name, $leftright = $element -replace ' ' -split '='
    $left, $right = $leftright -replace '[()]' -split ','
    $ElementHash.Add(
        $name, [PSCustomObject]@{
            L = $left
            R = $right
        }
    )
    if ($name -like '*A') {
        [void]$aNodes.add($name)
    }
    if ($name -like '*Z') {
        [void]$zNodes.add($name)
    }

}
#now find count between Zs and the name of those Zs
$moveArray = New-Object -TypeName System.Collections.ArrayList

foreach ($a in $aNodes) {
    $movecounter = 0
    $move = $a
    while ($move -notin $zNodes) {
        foreach ($lr in $lrmoves) {
            $move = $ElementHash.$move.$lr
            $movecounter++
            if ($move -in $zNodes) {
                $moveArray.Add(
                    [PSCustomObject]@{
                        Name   = $move
                        count  = $movecounter
                        origin = $a
                    }
                )
                break
            }
        } 
    }
}

# i tried bruteforcing for 30 mins, this is in years or somethnig like that. need some clever way.

# im thinking. for each path, find amount of moves between each '*z' and if it loops perfectly someplace,


# then foreachpath, add these Z steps up until they reach an equilibrium.

