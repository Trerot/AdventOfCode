$content = get-content .\2023\Powershell\Day4\testinput.txt
$sum = 0
$cardcounter = 0
$cardhash=@{}
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
$cardcounter ++
$cardhash.add($cardcounter,$wincount)
}

# now i have a card hash, whick is card number and amount of wins.
# plan is to use a for loop probably that does some magic and just adds things together using the value of hash.
