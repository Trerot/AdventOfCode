# Part 1
# $stuff = get-clipboard
# $stuff += ""
$caloriearray = New-Object -TypeName System.Collections.ArrayList
$count = 0
$elfnum = 1
$stuff.foreach({
        if ("" -ne $_) {
            $count += [int]$_
        }
        else {
            [void]$caloriearray.add(
                [pscustomobject]@{
                    totalcalories = $count
                    ElfNumber     = $elfnum
                })
            $elfnum ++
            $count = 0
        } 
    })
    $largestnum = ($caloriearray.totalcalories | sort-object -Descending)[0]
    $answer = $caloriearray.where({$_.totalcalories -eq "$largestnum"})
# part 2
$sum = 0
($caloriearray.totalcalories | sort-object -Descending)[0..2].foreach({
    $sum += $_
})
