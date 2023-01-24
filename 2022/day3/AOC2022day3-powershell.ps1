$stuff = get-content ".\day3\AOC2022day3-PuzzleInput.txt"
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
for ($i = 0; $i -lt $stuff.count; $i += 3) {

    $previous = $null
    $stuff[$i..($i + 2)].foreach({
        $Current = $_.tochararray()
        if($null -ne $previous){
           $previous = (Compare-Object $Current $previous -IncludeEqual -ExcludeDifferent).inputobject
        }
        else{$previous = $Current}
        })
        $previous
        $sum += $hash[[char]$previous[0]]
}
$sum