#task 1 done 
$stuff = get-puzzleinput -day 8 -year 2021
$stufflinesplit = $stuff.Split("`n")


$stuffsplit = $stufflinesplit.Split("|")
$test ="be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
fgae cfgab fg bagce"
$stufflinesplit = $test.Split("`n")
$stuffsplit = $stufflinesplit

$even = New-Object -TypeName System.Collections.ArrayList
$odd = New-Object -TypeName System.Collections.ArrayList
0..$stuffsplit.count | ForEach-Object { if ($_ % 2 -eq 0) { $even.add($stuffsplit[$_]) } }
0..$stuffsplit.count | ForEach-Object { if ($_ % 2 -eq 1) { $odd.add($stuffsplit[$_]) } }


$oddsplit = $odd -split " "

$num0 = New-Object -TypeName System.Collections.ArrayList
$num1 = New-Object -TypeName System.Collections.ArrayList
$num2 = New-Object -TypeName System.Collections.ArrayList
$num3 = New-Object -TypeName System.Collections.ArrayList
$num4 = New-Object -TypeName System.Collections.ArrayList
$num5 = New-Object -TypeName System.Collections.ArrayList
$num6 = New-Object -TypeName System.Collections.ArrayList
$num7 = New-Object -TypeName System.Collections.ArrayList
$num8 = New-Object -TypeName System.Collections.ArrayList
$num9 = New-Object -TypeName System.Collections.ArrayList
$oddsplit.foreach({
        switch ($_.length) {
            2 { $num1.add($_) }
            3 { $num7.add($_) }
            4 { $num4.add($_) }
            7 { $num8.add($_) }
            Default {}
        }
    })
$sum = 0
(Get-Variable -name num*).foreach({ $sum = $sum + $_.value.count })
$sum

#task two after work. maybe later if i have the time. 

#this is what i need to do. and combine it with replacing the map with the new config.
$sum = 0
$even.ForEach({
        $evensplit = $_ -split " "
        $string = ""
        $evensplit.foreach({
            switch ($x) {
                "acedgfb" { $string+="8" }
                "cdfbe" { $string+="5" }
                "gcdfa" { $string+="2" }
                "fbcad" { $string+="3" }
                "dab" { $string+="7" }
                "cefabd" { $string+="9" }
                "cdfgeb" { $string+="6" }
                "eafb" { $string+="4" }
                "cagedb" { $string+="0" }
                "ab" { $string+="1" }
            }
            })
            $string
            $sum = $sum + [int]$string

    })


