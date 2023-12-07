$collection = get-content .\2023\Powershell\Day7\testinput.txt
$games = new-object -TypeName System.Collections.ArrayList
$hashgames = @{}
$cardRanks = @{
  'A' = 14
  'K' = 13
  'Q' = 12
  'J' = 11
  'T' = 10
  9   = 9
  8   = 8
  7   = 7
  6   = 6
  5   = 5
  4   = 4
  3   = 3
  2   = 2
  1   = 1
}
# just making a games array, with bid, hands and rank
$counter = 0
foreach ($line in $collection) {
  $hand, [int]$bid = $line -split ' '
  $group = $hand.ToCharArray() | Group-Object | Sort-Object count -Descending
  switch ($group.count) {
    1 {
      #'5 of a kind' this one fails, becasse 5 count is just 1 not 5
      $HandPower = 7
    }
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
  $strenghtarray = 0
  [void]$games.Add([PSCustomObject]@{
      Hand       = $hand
      Bid        = $bid
      HandPower  = $HandPower
      Rank       = 0
      multiply   = 0
      HandNumber = $counter
      Strenghtarray = $strenghtarray
    })
  $hashgames.Add($counter , [PSCustomObject]@{
      Hand       = $hand
      Bid        = $bid
      HandPower  = $HandPower
      Rank       = 0
      multiply   = 0
      HandNumber = $counter
    })
  $counter++
}

# $cardrank
# hashtable to quickly get cardrank of aces, king etc. example $cardrank.a $cardrank.k

# $games
# arraylist with hand, bid, handpower(ranking of possible hands) and multiply(bid*rank)
# its values rank is empty, which is needed to populate multiply

# to fill in rank we start with getting $games.count and $i = 0
# highest rank has the same rank as the number of games
# find all handpower 7, if its alone give it $games.count - $i as rank. then do $i++
# else compare each card until you find the winner.
$RankCounter = $games.count
for ($i = 7; $i -gt 0; $i--) {
  <# Action that will repeat until the condition is met #>
  $SameRankGames = $games.where({ $_.handpower -eq $i })
  if ($SameRankGames.count -eq 1) {
    ($hashgames.($SameRankGames.HandNumber)).rank = $RankCounter
    $RankCounter--
  }
  else{
    foreach ($item in $SameRankGames) {
      #if(){}

      # i need to do this to each thing
      ($hashgames.($SameRankGames.HandNumber)).rank = $RankCounter
      $RankCounter--

    }
  }

}




<# Every hand is exactly one type. From strongest to weakest, they are:
7 Five of a kind, where all five cards have the same label: AAAAA
6 Four of a kind, where four cards have the same label and one card has a different label: AA8AA
5 Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
4 Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
3 Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
2 One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
1 High card, where all cards' labels are distinct: 23456
 #>
