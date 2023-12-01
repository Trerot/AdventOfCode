$stuff = Get-Content "2023\Powershell\Day1\puzzleinput.txt"
$sum2 = 0
$stuff.foreach({
        $line = $_
        $line = $line -replace "eightwo", "82"
        $line = $line -replace "oneight", "18"
        $line = $line -replace "twone", "21"
        $line = $line -replace "one", "1"
        $line = $line -replace "two" , "2"
        $line = $line -replace "three" , "3" 
        $line = $line -replace "four" , "4"
        $line = $line -replace "five" , "5"
        $line = $line -replace "six" , "6"
        $line = $line -replace "seven" , "7" 
        $line = $line -replace "eight" , "8"
        $line = $line -replace "nine" , "9"

        $numbers = $line -replace "[^0-9]" 
        if ($numbers.Length -lt 2) {
            $sum2 += [int]([string]$numbers + [string]$numbers)
        }
        else {
            $sum2 += [int]([string]$numbers[0] + [string]$numbers[-1])
        }
    })
$sum2
