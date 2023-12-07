$Stuff = (get-content .\2023\Powershell\Day6\puzzleinput.txt) -replace '\D+'
$sum = 0
$Time = [int64]$stuff[0]
$Record = [int64]$stuff[1]
for ($ms = 0; $ms -lt $time; $ms++) {
    if ((($time - $ms) * $ms) -gt $record) {
        $sum ++
    }
}
$sum
