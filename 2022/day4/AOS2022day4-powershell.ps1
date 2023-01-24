 $stuff = get-content ".\day4\AOC2022day4-PuzzleInput.txt"
#$stuff = Get-Clipboard
$counter = 0
foreach ($item in $stuff) {
    $elf1, $elf2 = $item.split(',')
    [int]$elf1begin, [int]$elf1end = $elf1.split('-')
    [int]$elf2begin, [int]$elf2end = $elf2.split('-')

    if (($elf1begin -le $elf2begin -and $elf2end -le $elf1end) -or ($elf2begin -le $elf1begin -and $elf1end -le $elf2end)) {
        $counter ++
    }
}
$counter

## task 2
$counter = 0
foreach ($item in $stuff) {
    $elf1, $elf2 = $item.split(',')
    [int]$elf1begin, [int]$elf1end = $elf1.split('-')
    [int]$elf2begin, [int]$elf2end = $elf2.split('-')

    $elf1range = $elf1begin..$elf1end
    $elf2range = $elf2begin..$elf2end

    $var = $elf1range.ForEach({ $_ -in $elf2range })


    if ($var -eq $true) { $counter++ }
}
$counter