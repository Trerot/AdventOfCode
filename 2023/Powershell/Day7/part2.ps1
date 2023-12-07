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
foreach ($line in $collection) {
  $hand, [int]$bid = $line -split ' '
  $group = $hand.ToCharArray() | Group-Object | Sort-Object count -Descending
  # handpower switch
  switch ($group.count) {
    2 {
      # 4+1 or 3+2
      if ($group[0].count -eq 4) {
        #4j+1
        if ($group[0].name -eq 'J') { $HandPower = 7 }
        #4+1j
        if ($group[1].name -eq 'J') { $HandPower = 7 }
        #4+1
        if ($group[0].name -ne 'J' -and $group[1].name -ne 'J') { $HandPower = 6 }
      }
      # 3+2
      if ($group[0].count -eq 3) {
        # 3j+2
        if ($group[0].name -eq 'j') { $HandPower = 7 }
        #3+2j
        if ($group[1].name -eq 'j') { $HandPower = 7 }
        # 3+2
        if ($group[0].name -ne 'j' -and $group[1].name -ne 'j'  ) { $HandPower = 5 }
      }

    }
  
    3 {
      #3+1+1
      if ($group[0].count -eq 3) {
        # 3j+1+1
        if ($group[0].name -eq 'J') { $HandPower = 6 }
        # 3+1j+1
        if ($group[0].name -ne 'J' -and $group.name -contains 'J' ) { $HandPower = 6 }
        # 3+1+1
        if ($group.name -notcontains 'J') {
          $HandPower = 4
        }
        
      }
      # 2+2+1
      if ($group[0].count -eq 2) {
        # 2j + 2 + 1
        if ($group[0].name -eq 'j' -or $group[1].name -eq 'j' ) {
          #'four of a kind
          $HandPower = 6
        }
        # 2 + 2 + 1j
        if ($group[0].name -ne 'j' -and $group[1].name -ne 'j' -and $group[2].name -eq 'j' ) {
          # house 
          $HandPower = 5
        }
        # 2 + 2 + 1
        if ($group.name -notcontains 'J') {
          # two pair
          $HandPower = 3

        }
      }
    }
    4 {
      #2+1+1+1
      # 2j+1+1+1
      if ($group[0].name -eq 'j') {
        # three of a kind
        $HandPower = 4
      }
      # 2+1j+1+1
      if ($group[0].name -ne 'j' -and $group.name -contains 'J' ) {
        # three of a kind
        $HandPower = 4
      }
      # 2+1+1+1
      if ($group.name -notcontains 'j') {
        # a pair
        $HandPower = 2
      }
      
    }
    5 {
      # 1+1+1+1+1 or 5
      if ($group[0].count -eq 5) { $HandPower = 7 }
      else {
        #'highcard'
        if ($group.name -contains 'j') {
          # three of a kind
          $HandPower = 2
        }
        if ($group.name -notcontains 'j') {
          # three of a kind
          $HandPower = 1
        }
        # or pair if joker is here
      }

    }
  }
  # i kinda did the strength array thing before i learned i could multi sort.. but lets just roll with it
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