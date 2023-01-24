#task 1
$stuff = get-puzzleinput -day 3 -year 2021
$stuffconv = $stuff | ConvertFrom-Csv -Header binarynum

$length = $stuffconv.binarynum[0].length 
$range = 0..$($length - 1)

$range.foreach({
        New-Variable -Name "0count_$_" -Value 0 -Force
        New-Variable -Name "1count_$_" -Value 0 -Force
    })

$stuffconv.binarynum.foreach({
        $item = $_
        $range.foreach({
                $rangenum = $_
                switch ($item[$rangenum]) {
                    "0" { Set-Variable -name "0count_$rangenum" -Value ((get-variable -name  "0count_$rangenum").Value + 1) }
                    "1" { Set-Variable -name "1count_$rangenum" -Value ((get-variable -name  "1count_$rangenum").Value + 1) }
                    Default {}
                }
            })
    })
#this sorting gave me such a bother...
$zero = get-variable -name 0count* | sort-object { [int]($_.name -split "-")[1] }
$one = get-variable -name 1count* | sort-object { [int]($_.name -split "-")[1] }

# getting gammarate
$arraylist = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
        if ($zero[$_].Value -gt $one[$_].Value) {
            [void]$arraylist.add("0")
        }
        else {
            [void]$arraylist.add("1")
        }
    })
$gammarate = -join $arraylist

# getting epsilon rate. which is just reverse realy 
$arraylist = New-Object -TypeName System.Collections.ArrayList
$range.foreach({
        if ($zero[$_].Value -lt $one[$_].Value) {
            [void]$arraylist.add("0")
        }
        else {
            [void]$arraylist.add("1")
        }
    })
$epsilonrate = -join $arraylist

$answer = ([convert]::toint32($epsilonrate, 2)) * ([convert]::toint32($gammarate, 2))

$answer | Set-Clipboard


#task 2
$stuff = get-puzzleinput -day 3 -year 2021
$stuffconv = $stuff | ConvertFrom-Csv -Header binarynum

$range = 0..11
$array = $stuffconv.binarynum
$range.foreach({
        $rangenum = $_
        $one = New-Object -TypeName System.Collections.ArrayList
        $zero = New-Object -TypeName System.Collections.ArrayList
        $array.foreach({
                $item = $_
                $num = $_[$rangenum]
                switch ($num) {
                    0 { [void]$zero.add($item) }
                    1 { [void]$one.add($item) }
                }
            })
        if ($one.count -ge $zero.Count) {
            $array = $one
        }
        else {
            $array = $zero
        }
        if ($array.count -eq 1) {
            $bonusfirst = $array
        }
    })
$first = $array
#done this, now other way around. fewest bits.
$range = 0..11
$array = $stuffconv.binarynum
$range.foreach({
        $rangenum = $_
        $one = New-Object -TypeName System.Collections.ArrayList
        $zero = New-Object -TypeName System.Collections.ArrayList
        $array.foreach({
                $item = $_
                $num = $_[$rangenum]
                switch ($num) {
                    0 { [void]$zero.add($item) }
                    1 { [void]$one.add($item) }
                }
            })
        if ($zero.count -le $one.Count) {
            $array = $zero
        }
        else {
            $array = $one
        }
        if ($array.count -eq 1) {
            $bonussecond = $array
        }
    })
$second = $array
if ($second.count -eq 0 ) {
    $second = $bonussecond
}
if ($first.count -eq 0 ) {
    $first = $bonusfirst
}
$answer = ([convert]::toint32($first, 2)) * ([convert]::toint32($second, 2))
$answer
