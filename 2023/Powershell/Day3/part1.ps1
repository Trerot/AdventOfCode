
$content = Get-Content .\2023\Powershell\Day3\puzzleinput.txt

$global:NumberArray = New-Object -TypeName System.Collections.ArrayList
$global:SymbolArray = New-Object -TypeName System.Collections.ArrayList
$linecounter = 0

# two functions to made to add numbers and symbols into $symbolarray and $numberarray
function Add-Number {
    param (
        $number, $Numberposition, $linecounter
    )
    [void]$Global:NumberArray.Add([PSCustomObject]@{
            number       = [int]$number
            position     = [int]$Numberposition
            line         = [int]$linecounter
            numberLength = [int]$number.length
            rangeStart   = [int]$Numberposition - 1
            rangeEnd     = [int]$Numberposition + [int]$number.length
        }
    )
    $global:Numberposition = $null
    $global:number = $null
}
function Add-Symbol {
    param (
        $line,
        $position
    )
    [void]$global:SymbolArray.Add([PSCustomObject]@{
            line     = $line
            position = $position
        })
}

# scan through and populate the array lists $symbolarray and $numberarray
foreach ($line in $content) {
    $charCounter = 0
    $Numberposition = $null
    $number = $null
    foreach ($char in $line.ToCharArray()) {
        # symbols
        if ($char -match "[^0-9.]" ) {
            Add-Symbol -line $linecounter -position $charCounter
            if ($null -ne $number) {
                Add-Number -number $number -Numberposition $Numberposition -linecounter $linecounter
            }
        } 
        # dots
        if ($char -match "[.]" ) {
            if ($null -ne $number) {
                Add-Number -number $number -Numberposition $Numberposition -linecounter $linecounter
            }
        } 
        # numbers
        if ($char -match "[0-9]" ) {
            $number = "$number" + "$char"
            if ($null -eq $Numberposition) {
                $Numberposition = $charCounter
            }
        } 
        # if it reaches end then do something
        if ($charcounter -eq $line.Length) {
            Add-Number -number [int]$number -Numberposition $Numberposition -linecounter $linecounter
        }
        $charcounter++
    }
    $linecounter++
}
# part above seems fine. generates $symbolarray and $numberarray
$sum = 0
# loop through the numberarray and create the sum
foreach ($Number in $NumberArray) {
    $match = $false
    foreach ($symbol in $SymbolArray) {
        if (($number.line - 1) -eq $symbol.line) {
            if ($symbol.position -ge $number.rangeStart -and $symbol.position -le $number.rangeEnd) {
                $match = $true
            }
        }
        if ($number.line -eq $symbol.line) {
            if ($symbol.position -ge $number.rangeStart -and $symbol.position -le $number.rangeEnd) {
                $match = $true
            }
        }
        if (($number.line + 1) -eq $symbol.line) {
            if ($symbol.position -ge $number.rangeStart -and $symbol.position -le $number.rangeEnd) {
                $match = $true
            }
        }
    }
    if ($match) { $sum += [int]$number.number }
}

#profit ? it works with test data. but not with the actual puzzle set..
$sum

'---this below is just my notes for my attempts on my dataset---'
if ($sum -le 511086) { write-host "Sum is to low" }
else {
    write-host  "This could be right" 
    $sum
}
if ($sum -eq 511086 ) { write-host "511086  is wrong" }
if ($sum -eq 102395 ) { write-host "102395 is wrong" }
if ($sum -eq 43984) { write-host "43984 is wrong" }
