$content = get-content .\2023\Powershell\Day4\puzzleinput.txt
$sum = 0
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
    $score = 0 
    if ($wincount -eq 1) {
        $sum += 1
    }
    if ($wincount -gt 1) {
        $sum +=[math]::pow(2,($wincount-1))
    }
}
$sum