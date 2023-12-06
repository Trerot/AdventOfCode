$stuff = Get-Content .\2023\Powershell\Day6\puzzleinput.txt
$null, $TimeRaces = $stuff[0] -replace ' ' -split ':'
$null, $DistanceRaces = $stuff[1] -replace ' ' -split ':'

$sum = 0
$RaceMs = [int64]$TimeRaces
$raceRecord = [int64]$DistanceRaces

for ($ms = 0; $ms -lt $RaceMs; $ms++) {
    <# Action that will repeat until the condition is met #>
    if ((($RaceMs - $ms) * $ms) -gt $raceRecord) {
        $sum ++
    }
}
$sum