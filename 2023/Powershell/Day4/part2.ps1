$content = get-content .\2023\Powershell\Day4\puzzleinput.txt
$sum = 0
$cardcounter = 0
$cardarray = New-Object -TypeName System.Collections.ArrayList
foreach ($card in $content) {
    $card = $card.split(':').split('|')
    $winningnumbers = $card[1].split(' ')
    $yournumbers = $card[2].split(' ')
    $wincount = 0
    foreach ($number in $winningnumbers) {
        if ($yournumbers -contains $number -and $number -ne '') {
            $wincount ++
        }
    }
    [void]$cardarray.add([PSCustomObject]@{
            card       = $cardcounter
            wincount   = $wincount
            multiplier = 1
            total      = 0
        })
    $cardcounter ++
}
$cardcounter = 0
for ($i = 0; $i -lt $cardarray.Count) {
    while ($cardarray[$i].multiplier -gt 0) {

        if ($cardarray[$i].wincount -gt 0) {

            for ($w = 1; $w -le ($cardarray[$i].wincount); $w++) {
                $cardarray[($i+$w)].multiplier ++
            }

        }
        $cardarray[$i].total ++
        $cardarray[$i].multiplier --
    }
    $i ++
}
($cardarray.total | Measure-Object -Sum).Sum