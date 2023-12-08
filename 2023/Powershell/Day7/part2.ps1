$collection = get-content .\2023\Powershell\Day7\puzzleinput.txt
$games = new-object -TypeName System.Collections.ArrayList
$cardRanks = @{
  'A' = 14
  'K' = 13
  'Q' = 12
  'J' = 1
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
# rank it
# this foreach turns a hand into a handarray, then groups similar cards
# 2 groups, is eiter 4+1 or 3+2, so just check the count on the biggest group to figure which is which.
# then count the jokers. and plot an if for each possible joker scenario in each possible group.
# at the end it populates the $games array, with the power of each card, and power of each hand.
foreach ($line in $collection) {
  $hand, [int]$bid = $line -split ' '
  $handarray = $hand.ToCharArray()
  $jcount = ($handarray | select-string 'j').count
  $group = $handarray | Group-Object | Sort-Object count -Descending
  switch ($group.count) {
    2 {
      # 4+1 or 3+2
      if ($group[0].count -eq 4) {
        #4j+1
        if ($jcount -eq 4) { $HandPower = 7 }
        #4+1j
        if ($jcount -eq 1) { $HandPower = 7 }
        #4+1
        if ($jcount -eq 0) { $HandPower = 6 }
      }
      # 3+2
      if ($group[0].count -eq 3) {
        # 3j+2
        if ($jcount -eq 3) { $HandPower = 7 }
        #3+2j
        if ($jcount -eq 2) { $HandPower = 7 }
        # 3+2
        if ($jcount -eq 0) { $HandPower = 5 }
      }
    }
    3 {
      #3+1+1
      if ($group[0].count -eq 3) {
        # 3j+1+1
        if ($jcount -eq 3) { $HandPower = 6 }
        # 3+1j+1
        if ($jcount -eq 1) { $HandPower = 6 }
        # 3+1+1
        if ($jcount -eq 0) {
          $HandPower = 4
        }
      }
      # 2+2+1
      if ($group[0].count -eq 2) {
        # 2j + 2 + 1
        if ($jcount -eq 2) {
          $HandPower = 6
        }
        # 2 + 2 + 1j
        if ($jcount -eq 1) {
          $HandPower = 5
        }
        # 2 + 2 + 1
        if ($jcount -eq 0) {
          $HandPower = 3
        }
      }
    }
    4 {
      #2+1+1+1
      # 2j+1+1+1
      if ($jcount -eq 2) {
        $HandPower = 4
      }
      # 2+1j+1+1
      if ($jcount -eq 1 ) {
        $HandPower = 4
      }
      # 2+1+1+1
      if ($jcount -eq 0) {
        $HandPower = 2
      }
    }
    5 {
      # 1+1+1+1+1 or 5
      if ($group[0].count -eq 5) { $HandPower = 7 }
      else {
        # 1j+1+1+1+1
        if ($jcount -eq 1) {
          $HandPower = 2
        }
        # 1+1+1+1+1
        if ($jcount -eq 0) {
          $HandPower = 1
        }
      }
    }
  }
  [void]$games.Add([PSCustomObject]@{
      Bid       = $bid
      HandPower = $HandPower
      Rank      = 0
      multiply  = 0
      1         = $cardranks."$($handarray[0])"
      2         = $cardranks."$($handarray[1])"
      3         = $cardranks."$($handarray[2])"
      4         = $cardranks."$($handarray[3])"
      5         = $cardranks."$($handarray[4])"
    })
}
# sort in order mentioned in -property. thats enough to sum everything together. 
$games = $games | Sort-Object -Property 'handpower', '1', '2', '3', '4', '5'
# sum it
$sum = 0
$RankCounter = 1
$games.bid.foreach({
    $sum += $RankCounter * $_
    $RankCounter++
  })
# answer it
$sum