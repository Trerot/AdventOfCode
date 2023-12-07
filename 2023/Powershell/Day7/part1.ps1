$collection = get-content .\2023\Powershell\Day7\puzzleinput.txt
$games = new-object -TypeName System.Collections.ArrayList
$cardRanks = @{
  'A' = 14
  'K' = 13
  'Q' = 12
  'J' = 11
  'T' = 10
  '9' = 9
  '8' = 8
  '7' = 7
  '6' = 6
  '5' = 5
  '4' = 4
  '3' = 3
  '2' = 2
  '1' = 1
}
# just making a games array, with bid, hands and rank
$counter = 0
foreach ($line in $collection) {
  $hand, [int]$bid = $line -split ' '
  $group = $hand.ToCharArray() | Group-Object | Sort-Object count -Descending
  switch ($group.count) {
    2 {
      if ($group[0].count -eq 4) {
        #'four of a kind'
        $HandPower = 6
      }
      else {
        #'fullhouse'
        $HandPower = 5
      }
    }
    3 {
      if ($group[0].count -eq 3) {
        #'three of a kind'
        $HandPower = 4
      }
      else {
        #'two pair'
        $HandPower = 3
      }
    }
    4 { 
      #'one pair'
      $HandPower = 2
    }
    5 {
      if ($group[0].count -eq 5) { $HandPower = 7 }
      else {
        #'highcard'
        $HandPower = 1
      }

    }
    Default {}
  }

  $strenghtarray = $hand.ToCharArray().foreach({ $cardranks.[string]$_ })

  [void]$games.Add([PSCustomObject]@{
      Hand      = $hand
      Bid       = $bid
      HandPower = $HandPower
      Rank      = 0
      multiply  = 0
      1         = $strenghtarray[0]
      2         = $strenghtarray[1]
      3         = $strenghtarray[2]
      4         = $strenghtarray[3]
      5         = $strenghtarray[4]
    })
}
# sort it and give it rank and multiply
$RankCounter = 1
$games = $games | Sort-Object -Property handpower, '1', '2', '3', '4', '5'
for ($i = 0; $i -lt $games.Count; $i++) {
  $games[$i].rank = $RankCounter
  $games[$i].multiply = $RankCounter * $games[$i].bid
  $RankCounter++
}
($games.multiply | Measure-Object -Sum).sum