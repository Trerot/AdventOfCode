$Content = get-content .\2023\Powershell\Day2\puzzleinput.txt
$sum = 0
$Content.foreach({
                $blue = 1
                $red = 1
                $green = 1
                $hands = (($_ -split ':')[1] -split ";" -split ',').trimstart()
                (($hands | select-string 'blue') -replace "[^0-9]").foreach({ if ([int]$_ -gt $blue) { $blue = [int]$_ } })
                (($hands | select-string 'red') -replace "[^0-9]" ).foreach({ if ([int]$_ -gt $red) { $red = [int]$_ } })
                (($hands | select-string 'green') -replace "[^0-9]").foreach({ if ([int]$_ -gt $green) { $green = [int]$_ } })
                $sum += $blue * $red * $green
        })
$sum