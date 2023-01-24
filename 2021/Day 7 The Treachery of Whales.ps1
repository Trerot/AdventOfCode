
$test = get-puzzleinput -day 7 -year 2021
Measure-Command -Expression {
    $crabs = New-Object -TypeName System.Collections.ArrayList
    $answer = 99999999999999
    ($test -split ",").foreach({ [void]$crabs.add($_) })
    
    $crabarray = $crabs
    $measurecrabs = ($crabarray | Measure-Object -AllStats)
    $crabrange = $measurecrabs.Minimum..$measurecrabs.Maximum
    
    $sumarray = New-Object -TypeName System.Collections.ArrayList
    $crabrange.foreach({
            $crabnum = [int]$_
            $sum = 0
            $crabarray.ForEach({
                    $num = [int]$_
                    $distance = [math]::abs($crabnum - $num)
                    $sum = $sum + $distance
                })
            if ($sum -lt $answer) {
                $answer = $sum
            }
        })
    $answer
}


$test = get-puzzleinput -day 7 -year 2021
Measure-Command -Expression {
    $crabs = New-Object -TypeName System.Collections.ArrayList
    $answer = 99999999999999
    ($test -split ",").foreach({ [void]$crabs.add($_) })
    
    $crabarray = $crabs
    $measurecrabs = ($crabarray | Measure-Object -AllStats)
    $crabrange = $measurecrabs.Minimum..$measurecrabs.Maximum
    
    $sumarray = New-Object -TypeName System.Collections.ArrayList
    $crabrange.foreach({
            $crabnum = [int]$_
            $sum = 0
            $crabarray.ForEach({
                    $num = [int]$_
                    $distance = [math]::abs($crabnum - $num)
                    $sum = $sum + ($distance * ($distance + 1) / 2)
                })
            if ($sum -lt $answer) {
                $answer = $sum
            }
        })
    $answer
}


#task 2 
# had to do some stuff because above method was to slow.-
$test = get-puzzleinput -day 7 -year 2021
Measure-Command -Expression {
    $answer = 114531288099
    $crabs = New-Object -TypeName System.Collections.ArrayList
    ($test -split ",").foreach({ [void]$crabs.add([int]$_) })
    $crabs.Sort()
    $range = $crabs[0]..$crabs[-1]

    $crabgroup = $crabs | Group-Object

    $counterhash = @{}
    $crabgroup.foreach({
            $counterhash.Add([int]$_.name, [int]$_.count)
        })
    }

    $range.foreach({
            $crabnum = [Int]$_
            $sum = [int]0
            $counterhash.Keys.ForEach({
                    $crabkey = [int]$_
                    $crabamount = $counterhash.$_
                    $distance = [math]::abs($crabnum - $crabkey)
                    $sum = $sum + (($distance * ($distance + 1) / 2) *$crabamount)
                })
            if ($sum -lt $answer) {
                $answer = $sum
            }
        })
    
}
$answer