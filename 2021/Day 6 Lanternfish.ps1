$stuff = get-puzzleinput -day 6 -year 2021
#create initial array
$stuffarraylist = New-Object -TypeName System.Collections.ArrayList
($stuff.split(',') | ForEach-Object { Invoke-Expression $_ }).foreach({ [void]$stuffarraylist.add([int64]$_) })

$counter = 0
while ($counter -lt 80) {
    $newarraylist = New-Object -TypeName System.Collections.ArrayList
    $stuffarraylist.foreach({
            switch ($_) {
                0 {
                    [void]$newarraylist.add(6)
                    [void]$newarraylist.add(8)
                }
                Default { [void]$newarraylist.add($_ - 1) }
            }
        })
    $stuffarraylist = $newarraylist
    $counter ++
    $counter
}



#task 2

#creating the counters
$stuff = get-puzzleinput -day 6 -year 2021
#create initial array
$stuffarraylist = New-Object -TypeName System.Collections.ArrayList
($stuff.split(',') | ForEach-Object { Invoke-Expression $_ }).foreach({ [void]$stuffarraylist.add([int64]$_) })
$stuffarraylist.foreach({
        switch ($_) {
            0 { $zero ++ }
            1 { $one ++ }
            2 { $two ++ }
            3 { $three ++ }
            4 { $four ++ }
            5 { $five ++ }
            6 { $six ++ }
            7 { $seven ++ }
            8 { $eight ++ }
        } })
$counter = 0
while ($counter -lt 256) {
    $tempzero = $zero
    $zero = $one
    $one = $two
    $two = $three
    $three = $four
    $four = $five
    $five = $six
    $six = $seven + $tempzero
    $seven = $eight
    $eight = $tempzero
    $counter ++
    $counter
}
$zero + $one + $two + $three + $four + $five + $six + $seven + $eight
