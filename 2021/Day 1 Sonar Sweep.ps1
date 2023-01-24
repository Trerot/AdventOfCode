# Task 1
$stuff = get-clipboard | where-object { $_ }
$arraylist = New-Object -TypeName System.Collections.ArrayList
$previous = 999999
    
foreach ($item in $stuff) {
    if ([int]$item -gt [int]$previous) {
        [void]$arraylist.add($item)
    }
    $previous = $item
}
"Answer is $($arraylist.count)"


# Task 2
#make the arrays and stuff
$arraylist = New-Object -TypeName System.Collections.ArrayList
$int1 = 0
$int2 = 2
$intrange = $int1..$int2

#sum all the number and add into an arraylist. dont have to limit the end. because only looking for positives anyway.
foreach ($item in $stuff) {
    $number = 0
    # sum them into a number
    $stuff[$intrange].foreach({ $number = $number + $_ })
    # expand int range 
    $int1++
    $int2++
    $intrange = $int1..$int2
    #add number to array. 
    $arraylist.add([int]$number)
}

$arraylist2 = New-Object -TypeName System.Collections.ArrayList
foreach ($item in $arraylist) {
    if ([int]$item -gt [int]$previous) {
        [void]$arraylist2.add($item)
    }
    $previous = $item
}
"Answer is $($arraylist2.count)"
