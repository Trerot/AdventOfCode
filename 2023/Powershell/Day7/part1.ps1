$collection = get-content .\2023\Powershell\Day7\testinput.txt
$games = new-object -TypeName System.Collections.ArrayList
# just making a games array, with bid, hands and rank
foreach ($line in $collection) {
    $hand,[int]$bid = $line -split ' '
  [void]$games.Add([PSCustomObject]@{
    Hand = $hand
    Bid = $bid
    rank = $null
  })
}
# planning on charrarray and grouping the objects.
$group = $games[2].Hand.ToCharArray() | Group-Object | Select-Object -ExpandProperty count | Group-Object | Select-Object -ExpandProperty count
#first find all the hands

$group
<# Every hand is exactly one type. From strongest to weakest, they are:

7 Five of a kind, where all five cards have the same label: AAAAA
6 Four of a kind, where four cards have the same label and one card has a different label: AA8AA
5 Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
4 Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
3 Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
2 One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
1 High card, where all cards' labels are distinct: 23456
 #>
