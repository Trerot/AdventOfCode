$stuff2 = get-content .\day2\AOC2022day2-PuzzleInput.txt
[int]$loss = 0
[int]$draw = 3
[int]$win = 6
[int]$rock = 1
[int]$paper = 2
[int]$scissors = 3
[int]$score = 0
$stuff2.foreach({
        $Opponent, $Me = $_.Split(" ")
        switch ($Opponent) {
            "A" { 
                switch ($Me) {
                    "X" { $score += $rock + $draw }
                    "Y" { $score += $paper + $win }
                    "Z" { $score += $scissors + $loss }
                }
            }
            "B" { 
                switch ($Me) {
                    "X" { $score += $rock + $loss }
                    "Y" { $score += $paper + $draw }
                    "Z" { $score += $scissors + $win }
                }
            }
            "C" { 
                switch ($Me) {
                    "X" { $score += $rock + $win }
                    "Y" { $score += $paper + $loss }
                    "Z" { $score += $scissors + $draw }
                }
            }
        }
    })
$Score 
# task 2
[int]$score = 0  
$stuff2.foreach({
        $Opponent, $Me = $_.Split(" ")
        switch ($Opponent) {
            "A" { 
                switch ($Me) {
                    "X" { $score += $loss + $scissors }
                    "Y" { $score += $draw + $rock }
                    "Z" { $score += $win + $paper }
                }
            }
            "B" { 
                switch ($Me) {
                    "X" { $score += $loss + $rock }
                    "Y" { $score += $draw + $paper }
                    "Z" { $score += $win + $scissors }
                }
            }
            "C" { 
                switch ($Me) {
                    "X" { $score += $loss + $paper }
                    "Y" { $score += $draw + $scissors }
                    "Z" { $score += $win + $rock }
                }
            }
        }
    })
$Score
