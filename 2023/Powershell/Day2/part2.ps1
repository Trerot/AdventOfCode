$Content = get-content .\2023\Powershell\Day2\puzzleinput.txt
$sum = 0
$Content.foreach({
                $hands = ($_ -split ':')[1] -split ";"
                $blue = 1
                $red = 1
                $green = 1
                ((($hands -split ',').TrimStart() | select-string 'blue') -replace "[^0-9]").foreach({ if([int]$_ -gt $blue){$blue = [int]$_} })
                ((($hands -split ',').TrimStart() | select-string 'red') -replace "[^0-9]" ).foreach({ if([int]$_ -gt $red){$red = [int]$_}  })
                ((($hands -split ',').TrimStart() | select-string 'green') -replace "[^0-9]").foreach({ if([int]$_ -gt $green){$green = [int]$_} })
                $pow = $blue * $red * $green
                $sum += $pow
        })
$sum