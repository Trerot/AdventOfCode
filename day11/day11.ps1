$monkey0 = [PSCustomObject]@{
    StartingItems = @(83, 62, 93)
    HandleCount   = 0
} 
$monkey1 = [PSCustomObject]@{
    StartingItems = @(90, 55)
    HandleCount   = 0
}
  
$monkey2 = [PSCustomObject]@{
    StartingItems = @(91, 78, 80, 97, 79, 88)
    HandleCount   = 0
}
  
$monkey3 = [PSCustomObject]@{
    StartingItems = @(64, 80, 83, 89, 59)
    HandleCount   = 0
}
  
$monkey4 = [PSCustomObject]@{
    StartingItems = @(98, 92, 99, 51)
    HandleCount   = 0
}
  
$monkey5 = [PSCustomObject]@{
    StartingItems = @(68, 57, 95, 85, 98, 75, 98, 75)
    HandleCount   = 0
}
  
$monkey6 = [PSCustomObject]@{
    StartingItems = @(74)
    HandleCount   = 0
}
  
$monkey7 = [PSCustomObject]@{
    StartingItems = @(68, 64, 60, 68, 87, 80, 82)
    HandleCount   = 0
}
$monkeylist = $monkey0, $monkey1, $monkey2, $monkey3, $monkey4, $monkey5, $monkey6, $monkey7

# 20 rounds
(1..20).foreach({
        # foreach monkey
        foreach ($x in (0..7)) {
    
            switch ($x) {
                0 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item * 17) / 3)
                            if ($thing % 2 -eq 0) { $monkeylist[1].StartingItems += $thing }
                            else { $monkeylist[6].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }  
                }
                1 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item + 1 ) / 3)
                            if ($thing % 17 -eq 0) { $monkeylist[6].StartingItems += $thing }
                            else { $monkeylist[3].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }   
                }
                2 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item + 3) / 3)
                            if ($thing % 19 -eq 0) { $monkeylist[7].StartingItems += $thing }
                            else { $monkeylist[5].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }   
                }
                3 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item + 5) / 3)
                            if ($thing % 3 -eq 0) { $monkeylist[7].StartingItems += $thing }
                            else { $monkeylist[2].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }   
                }
                4 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item * $item) / 3)
                            if ($thing % 5 -eq 0) { $monkeylist[0].StartingItems += $thing }
                            else { $monkeylist[1].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }   
                }
                5 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item + 2) / 3)
                            if ($thing % 13 -eq 0) { $monkeylist[4].StartingItems += $thing }
                            else { $monkeylist[0].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }  
                }
                6 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item + 4) / 3)
                            if ($thing % 7 -eq 0) { $monkeylist[3].StartingItems += $thing }
                            else { $monkeylist[2].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    } 
                }
                7 {
                    if ($monkeylist[$x].StartingItems.count -ne 0) {
                        foreach ($item in $monkeylist[$x].StartingItems) {
                            $thing = $null
                            $thing = [math]::Floor(($item * 19) / 3)
                            if ($thing % 11 -eq 0) { $monkeylist[4].StartingItems += $thing }
                            else { $monkeylist[5].StartingItems += $thing }
                            $monkeylist[$x].HandleCount ++
                        }
                        $monkeylist[$x].StartingItems = @()
                    }
                }
            }
        }
    })