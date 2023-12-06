$stuff = Get-Content .\2023\Powershell\Day5\puzzleinput.txt
$finalsum = 1
$null, $TimeRaces = $stuff[0] -split ':'
$TimeRaces = $TimeRaces -replace ' '
$null, $DistanceRaces = $stuff[1] -split ':'
$DistanceRaces = $DistanceRaces -replace ' '

$sum = 0
$RaceMs = [int64]$TimeRaces
$raceRecord = [int64]$DistanceRaces

for ($ms = 0; $ms -lt $RaceMs; $ms++) {
    <# Action that will repeat until the condition is met #>
    $timeLeft = $RaceMs - $ms
    $distance = $timeleft * $ms
    if ($distance -gt $raceRecord) {
        $sum ++
    }
}
$sum