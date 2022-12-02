$stuff = get-content .\AOC2022day2-PuzzleInput.txt

[int]$loss = 0
[int]$draw = 3
[int]$win = 6

[int]$rock = 1
[int]$paper = 2
[int]$scissors = 3

[int]$global:score = 0

function Play-RockPaperScissors {
    param (
        $Me,
        $Opponent
    )

    
}


$stuff.foreach({
        $Opponent, $Me = $_.Split(" ")

        switch ($Opponent) {
            "A" { 
                switch ($Me) {
                    "X" { $global:score += $rock + $draw }
                    "Y" { $global:score += $paper + $win }
                    "Z" { $global:score += $scissors + $loss }
                }
            }
            "B" { 
                switch ($Me) {
                    "X" { $global:score += $rock + $loss }
                    "Y" { $global:score += $paper + $draw }
                    "Z" { $global:score += $scissors + $win }
                }
            }
            "C" { 
                switch ($Me) {
                    "X" { $global:score += $rock + $win }
                    "Y" { $global:score += $paper + $loss }
                    "Z" { $global:score += $scissors + $draw}
                }
            }
        }

    })
    $global:Score 
    # task 2
$stuff = "A Y","B X","C Z"
