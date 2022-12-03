#$stuff = get-content ".\day3\AOC2022day3-PuzzleInput.txt"
$array = 'a'..'z' + 'A'..'Z'
$counter = 1
$hash = @{}
$array.foreach({
        $hash.add($_, $counter )
        $counter++
    })
$sum = 0
$stuff.ForEach({
        $line = $_
        $firsthalf = $line[0..($line.Length / 2 - 1)]
        $secondhalf = $line[($line.length / 2)..($line.Length - 1)]
        $theThing = (Compare-Object $firsthalf $secondhalf -IncludeEqual -ExcludeDifferent).inputobject[0]
        $sum += $hash[$theThing]
    })
$sum

# part two!
$sum = 0
for ($i = 0; $i -lt $stuff.count - 3; $i += 3) {

    $trioOfTrios = $null
    $stuff[$i..($i - 3)].foreach({
            $trioOfTrios += ($_.tochararray() | Group-Object).where({ $_.count -eq 1 }).name.foreach({ [char]$_ })
        })

}
# groups of three, all carry same badge, for other items, max two carry it.