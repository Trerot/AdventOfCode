$stuff = Get-Content "C:\Users\david\REPOS\AdventOfCode2022\2023\Powershell\day1puzzleinput.txt"
$test= Get-Content "C:\Users\david\REPOS\AdventOfCode2022\2023\Powershell\day1TestInput.txt"
$sum = 0
$stuff.foreach({
        $numbers = $_ -replace "[^0-9]" 
        if ($numbers.Length -lt 2) {
            $sum += [int]([string]$numbers + [string]$numbers)
        }
        else {
            $sum += [int]([string]$numbers[0] + [string]$numbers[-1])
        }
    })
$sum
## part two
$sum2 = 0
$stuff.foreach({
        $line = $_
        $line = $line -replace "one", "o1n"
        $line = $line -replace "two" , "t2o"
        $line = $line -replace "three" , "t3e" 
        $line = $line -replace "four" , "f4r"
        $line = $line -replace "five" , "f5e"
        $line = $line -replace "six" , "s6x"
        $line = $line -replace "seven" , "s7n" 
        $line = $line -replace "eight" , "e8t"
        $line = $line -replace "nine" , "n9e"

        $numbers = $line -replace "[^0-9]" 
        if ($numbers.Length -lt 2) {
            [int]([string]$numbers + [string]$numbers)
            $sum2 += [int]([string]$numbers + [string]$numbers)
        }
        else {
            [int]([string]$numbers[0] + [string]$numbers[-1])
            $sum2 += [int]([string]$numbers[0] + [string]$numbers[-1])
        }
    })

$sum2
#this was to low 53799
