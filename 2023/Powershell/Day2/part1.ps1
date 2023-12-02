$Data= get-content .\2023\Powershell\day2\puzzleinput.txt

$RedLimit = 12
$GreenLimit = 13
$BlueLimit = 14
$Gamesum = 0

$Data.foreach({
                $gamenumber, $data = $_ -split ':'
                $gamenumber = $gamenumber -replace "[^0-9]" 
                $hands = $data -split ";"
                $handcount = $hands.count
                $possibleGameCount = 0
                $hands.foreach({
                                $hand = $_ -split ','
                                $colorAmount = $hand.count
                                $colorCounter = 0
                                $hand.ForEach({
                                                $cube = $_ -split ' '
                                                switch ($cube[-1]) {
                                                        'blue' {
                                                                if ([int]$cube[1] -le $BlueLimit) {
                                                                        $colorCounter ++
                                                                } 
                                                        }
                                                        'red' {
                                                                if ([int]$cube[1] -le $RedLimit) {
                                                                        $colorCounter ++
                                                                }
                                                        }
                                                        'green' {  
                                                                if ([int]$cube[1] -le $GreenLimit) {
                                                                        $colorCounter ++
                                                                }
                                                        }
                                                        Default {}
                                                }
                                        })
                                if ($colorAmount -eq $colorCounter) {
                                        $possibleGameCount ++
                                }
                        })
                if ($possibleGameCount -eq $handcount) {
                        $gamesum +=  $gamenumber
                }
        })
$Gamesum
