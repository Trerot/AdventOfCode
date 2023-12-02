$Content = get-content .\2023\Powershell\Day2\puzzleinput.txt
$sum = 0
$Content.foreach({
                $hands = ($_ -split ':')[1] -split ";"
                $blue = New-Object -TypeName System.Collections.ArrayList
                $red = New-Object -TypeName System.Collections.ArrayList
                $green = New-Object -TypeName System.Collections.ArrayList
                ((($hands -split ',').TrimStart() | select-string 'blue') -replace "[^0-9]").foreach({ [void]$blue.add([int]$_) })
                ((($hands -split ',').TrimStart() | select-string 'red') -replace "[^0-9]" ).foreach({ [void]$red.add([int]$_) })
                ((($hands -split ',').TrimStart() | select-string 'green') -replace "[^0-9]").foreach({ [void]$green.add([int]$_) })
                $blue.sort()
                $red.sort()
                $green.sort()
                if (!($blue[-1] -ge 1)) { $blue = 1 } else { $blue = $blue[-1] }
                if (!($red[-1] -ge 1)) { $red = 1 } else { $red = $red[-1] }
                if (!($green[-1] -ge 1)) { $green = 1 } else { $green = $green[-1] }
                $pow = $blue * $red * $green
                $sum += $pow
        })
$sum