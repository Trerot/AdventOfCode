$Stuff = get-content "day6\AOC2022day6-puzzleinput.txt"
$chararray = $Stuff.ToCharArray()
$task1Solved = $false
$task2Solved = $false

for ($i = 3; $i -lt $chararray.Count; $i++) {
    #task 1
    $charset = $chararray[($i - 3)..$i]
    if (($charset | Group-Object).name.count -eq 4 -and $task1Solved -eq $false) {
        $i + 1 # this is the answer for task 1
        $task1Solved = $true
    }
    #task 2
    $charset2 = $chararray[($i - 13)..$i]
    if($i -gt 13 -and ($charset2 | Group-Object).name.count -eq 14 -and $task2Solved -eq $false){
        $i + 1 # this is answer for task 2
        $task2Solved = $true
    }
}