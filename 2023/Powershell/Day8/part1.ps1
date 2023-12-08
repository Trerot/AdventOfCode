$stuff = get-content .\2023\Powershell\Day8\puzzleinput.txt

$lrmoves = $stuff[0].ToCharArray()
$ElementHash=@{}
foreach($element in $stuff[2..($stuff.count)]){
  $name,$leftright=$element -replace ' ' -split '='
  $left,$right = $leftright -replace '[()]' -split ','
  $ElementHash.Add(
    $name,[PSCustomObject]@{
      L = $left
      R = $right
    }
  )
}

$start = 'AAA'
$goal = 'ZZZ'
 $movecounter = 0
$move = $start

while ($move -ne $goal) {
  foreach ($lr in $lrmoves) {
    $move = $ElementHash.$move.$lr
    $movecounter++
    if($move -eq $goal){
      break
    }
  }
}
$movecounter