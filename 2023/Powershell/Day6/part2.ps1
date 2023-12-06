# getting the content ready
$stuff = Get-Content C:\Users\davhei15\repos\AdventOfCode2022\2023\Powershell\Day6\puzzleinput.txt
$null, $TimeRaces = $stuff[0] -replace ' ' -split ':'
$null, $DistanceRaces = $stuff[1] -replace ' ' -split ':'
$sum = 0
$RaceMs = [int64]$TimeRaces
$raceRecord = [int64]$DistanceRaces

# ------------------SingleCore way ------------
for ($ms = 0; $ms -lt $RaceMs; $ms++) {
    <# Action that will repeat until the condition is met #>
    if ((($RaceMs - $ms) * $ms) -gt $raceRecord) {
        $sum ++
    }
}
$sum
# ------------------Multicore way ------------
# 
# amount of cpu threads, just set it manualy for now. 
$ThreadCount = 8
# split it into equal parts that i shove into an hashlist
$partsize = [math]::floor($racems/$ThreadCount)
$arraylist = New-Object -TypeName system.Collections.ArrayList
$partcounter = 0
$hasharray = @{}
foreach($number in (1..$ThreadCount)){
    $end = $partsize+$partcounter-1
if($number -eq $ThreadCount){
    $end = $racems
}
$hasharray.add($number,$partcounter..$end)
    $partcounter += $partsize
}


# creating hashcounter to count all the threads at the same time. 
$hash = [hashtable]::Synchronized(@{})
(1..$ThreadCount).foreach({$hash.$_= 0})
# runnig the loop
1..$ThreadCount | ForEach-Object -ThrottleLimit $ThreadCount  -Parallel {
    $hasharray = $using:hasharray
    $hash = $using:hash 
    $RaceMs = $using:RaceMs
    $raceRecord = $using:raceRecord
    foreach($num in $hasharray.$_){
        if ((($RaceMs - $num) * $num) -gt $raceRecord) {
            $hash.$_ ++
        }
    }
}
# getting the answer
($hash.values | measure-object -sum).sum
