
$content = Get-Content .\2023\Powershell\Day3\testinput.txt

function Add-Number {
    param (
        $number, $Numberposition, $linecounter
    )
    [void]$Global:NumberArray.Add([PSCustomObject]@{
            number   = [int]$number
            position = [int]$Numberposition
            line     = [int]$linecounter
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

# do stuff here 
$sum = 0
foreach ($Number in $NumberArray) {
    # number has .number .position .line
    
    $numberCharLength = [int]($number.number.ToString().length)
    $numberStartPos = [int]($Number.position - 1)
    $numberEndPos = [int]($number.position + $numberCharLength)
    $match = $false
    
    foreach ($item in $SymbolHash.($number.line - 1)) {
        if ([int]$item -ge $numberStartPos -and $item -le $numberEndPos) {
            $match = $true
        }
    }
    foreach ($item in $SymbolHash.($number.line)) {
        if ([int]$item -ge $numberStartPos -and $item -le $numberEndPos) {
            $match = $true
        }
    }
    foreach ($item in $SymbolHash.($number.line + 1)) {
        if ([int]$item -ge $numberStartPos -and $item -le $numberEndPos) {
            $match = $true
        }
    }
    if ($match) {
        $sum += $number.number
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
