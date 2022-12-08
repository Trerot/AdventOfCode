#$sampleset = get-content "C:\Users\david\REPOS\AdventOfCode2022\day8\sampleset.txt"
$sampleset = get-content "C:\Users\david\REPOS\AdventOfCode2022\day8\AOC2022day8-puzzleinput.txt"
# for sample set this is 5, this file is 99*99
$gridsize = 99 

$TotalVisibleTrees = 0

$hashtable = @{}

$rowcounter = 1
foreach ($row in $sampleset) {
    $columncounter = 1
    $row.ToCharArray().foreach({
            $hashtable.Add("$rowcounter,$columncounter", "$_")
            
            $columncounter ++
        })
    $rowcounter ++
}
foreach ($item in $hashtable.GetEnumerator()) {
    [int]$r, [int]$c = $item.Name.Split(',')

    $ishiddendown = $false
    $ishiddentop = $false
    $ishiddenleft = $false
    $ishiddenright = $false
    $loopbreak = $false
    $upcount = 0
    $downcount = 0
    $leftcount = 0
    $rightcount = 0
    
    if ($r -eq $gridsize -or $r -eq 1 -or $c -eq $gridsize -or $c -eq 1) { 
        $loopbreak = $true
    }
    $up = $null
    $down = $null
    $left = $null
    $right = $null
    if ($loopbreak -eq $false) {
        $up = 1..($r - 1) 
        $down = ($r + 1)..$gridsize 
        $left = 1..($c - 1) 
        $right = ($c + 1)..$gridsize

        #looping up
        for ($i = 0; $i -lt $up.count; $i++) {
            if ($hashtable."$($up[$i]),$c" -ge $item.Value) {
                $ishiddentop = $true ; break
            }
        } 
        #looping down
        if ($ishiddentop -eq $true ) {
            #  'test'
            for ($i = 0; $i -lt $down.Count; $i++) {
                if ($hashtable."$($down[$i]),$c" -ge $item.Value) { $ishiddendown = $true ; break }
            } 
        }
        #looping left
        if ($ishiddendown -eq $true -and $ishiddentop -eq $true) {
            for ($i = 0; $i -lt $left.Count; $i++) {
                if ($hashtable."$r,$($left[$i])" -ge $item.Value) { $ishiddenleft = $true; break }
            } 
        }
        #looping right
        if ($ishiddenleft -eq $true -and $ishiddendown -eq $true -and $ishiddentop -eq $true ) {
            for ($i = 0; $i -lt $right.count; $i++) {
                if ($hashtable."$r,$($right[$i])" -ge $item.Value) { $ishiddenright = $true ; break }
            } 
        } 
    }
    if ($loopbreak) { $TotalVisibleTrees++ }
    elseif ($ishiddenleft -eq $false -or $ishiddendown -eq $false -or $ishiddentop -eq $false -or $ishiddenright -eq $false ) { $TotalVisibleTrees++ }
}
$TotalVisibleTrees
# taaaaaaask 2 ----------------------------------------------------------------------------------------------------------------------------------
$HighestScenicScore = 0
foreach ($item in $hashtable.GetEnumerator()) {
    [int]$r, [int]$c = $item.Name.Split(',')

    $loopbreak = $false
    if ($r -eq $gridsize -or $r -eq 1 -or $c -eq $gridsize -or $c -eq 1) { 
        $loopbreak = $true
    }

    if ($loopbreak -eq $false) {
        $up = ($r - 1)..1
        $down = ($r + 1)..$gridsize 
        $left = ($c - 1)..1
        $right = ($c + 1)..$gridsize
        $upcount = 0
        $downcount = 0
        $leftcount = 0
        $rightcount = 0

        for ($i = 0; $i -lt $up.count; $i++) {
            $upcount++
            if ($hashtable."$($up[$i]),$c" -ge $item.Value) { break }
        } 
        for ($i = 0; $i -lt $down.Count; $i++) {
            $downcount++
            if ($hashtable."$($down[$i]),$c" -ge $item.Value) { break }
        } 
        for ($i = 0; $i -lt $left.Count; $i++) {
            $leftcount++
            if ($hashtable."$r,$($left[$i])" -ge $item.Value) { break }
        } 
        for ($i = 0; $i -lt $right.count; $i++) {
            $rightcount++
            if ($hashtable."$r,$($right[$i])" -ge $item.Value) { break }
        } 
        $score = $upcount * $downcount * $leftcount * $rightcount
        if ($score -gt $HighestScenicScore) { $HighestScenicScore = $score }
    }
}
$HighestScenicScore