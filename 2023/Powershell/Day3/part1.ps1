
$content = Get-Content .\2023\Powershell\Day3\testinput.txt
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
# building a symbolhash
$SymbolHash = @{}
$global:NumberArray = New-Object -TypeName System.Collections.ArrayList
$linecounter = 0

foreach ($line in $content) {


    $charCounter = 0
    $Numberposition = $null
    $number = $null

    # this creates hash table for symbols
    foreach ($char in $line.ToCharArray()) {

        # symbols
        if ($char -match "[^0-9.]" ) {
            if ($null -eq $SymbolHash.$linecounter) {
                $SymbolHash.$linecounter = $charCounter
            }
            else {
                $SymbolHash.$linecounter = $SymbolHash.$linecounter, $charCounter
            }
            
            if ($number.length -gt 0) {
                Add-Number -number $number -Numberposition $Numberposition -linecounter $linecounter
            }
        } 
        # dots
        if ($char -match "[.]" ) {
            if ($number.length -gt 0) {
                Add-Number -number $number -Numberposition $Numberposition -linecounter $linecounter
            }
        } 
        # numbers
        if ($char -match "[0-9]" ) {
            $number += [string]$char
            if ($null -eq $Numberposition) {
                $Numberposition = $charCounter
            }
        } 
        # if it reaches end then do something
        if ($charcounter -eq $line.Length) {
            Add-Number -number $number -Numberposition $Numberposition -linecounter $linecounter
        }

        $charcounter++
    }
    $linecounter++
}
# part above seems fine. 
# do stuff here 
$sum = 0
foreach ($Number in $NumberArray) {
    # number has .number .position .line
    $symbolpos = $SymbolHash.($number.line) , $SymbolHash.($number.line - 1) , $SymbolHash.($number.line + 1)
    $match = $false
    foreach ($symbol in $symbolpos) {
        if ($symbol -ge $number.rangeStart -and $symbol -le $number.rangeEnd) {
            $match = $true
        }
    }
    if ($match) {
        $sum += [int]$number.number
    }
}

$sum
if ($sum -le 511086 -or $sum -le 102395) { "Sum is to low" }
else {
    "This could be right" 
    $sum
}
if ($sum -eq 511086 ) { "511086  is wrong" }
if ($sum -eq 102395 ) { "102395 is wrong" }
if ($sum -eq 43984) { "43984 is wrong" }
