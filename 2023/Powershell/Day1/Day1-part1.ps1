$stuff = Get-Content "2023\Powershell\Day1\puzzleinput.txt"
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