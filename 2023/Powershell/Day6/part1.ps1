$stuff = Get-Content .\2023\Powershell\Day5\puzzleinput.txt
$finalsum = 1
$null, $TimeRaces = $stuff[0] -split ':'
$TimeRaces = ($TimeRaces -split ' ').Where({ $_ -ne '' })
$null, $DistanceRaces = $stuff[1] -split ':'
$DistanceRaces = ($DistanceRaces -split ' ').where({ $_ -ne '' })


for ($raceNum = 0; $raceNum -lt $TimeRaces.Count; $raceNum++) {
    $sum = 0
    $RaceMs = [int]$TimeRaces[$raceNum]
    $raceRecord = [int]$DistanceRaces[$raceNum]

    for ($ms = 0; $ms -lt $RaceMs; $ms++) {
        <# Action that will repeat until the condition is met #>
        $timeLeft = $RaceMs - $ms
        $distance = $timeleft * $ms
        if ($distance -gt $raceRecord) {
            $sum ++
        }
        "$sum is the sum for race $racenum"
    }
$finalsum = $finalsum * $sum
}
$finalsum