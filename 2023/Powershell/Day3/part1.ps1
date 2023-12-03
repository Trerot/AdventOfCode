
$content = Get-Content .\2023\Powershell\Day3\testinput.txt

function Add-Number {
    param (
        $number, $Numberposition, $linecounter
    )
    [void]$Global:NumberArray.Add([PSCustomObject]@{
            number   = $number
            position = $Numberposition
            line     = $linecounter
        }
    )
    $global:Numberposition = $null
    $global:number = $null
}


# building a symbolhash
$SymbolHash = @{}
$NumberHash = @{}
$global:NumberArray = New-Object -TypeName System.Collections.ArrayList
$linecounter = 0
foreach ($line in $content) {


    $charCounter = 0
    $symbolposition = $null
    $Numberposition = $null

    $number = $null

    # this creates hash table for symbols
    foreach ($char in $line.ToCharArray()) {

        # symbols
        if ($char -match "[^0-9.]" ) {
            $symbolposition += , $charCounter
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
    $SymbolHash.add($linecounter, $symbolposition)
    $NumberHash.add($linecounter, $numberobject)
    #this should create a table for numbers
    
    
    $linecounter++
}

# do stuff here 
$sum = 0
foreach ($Number in $NumberArray) {
    # number has .number .position .line
    
    $NumberPositions = ($Number.position - 1)..($number.position + $Number.number.length)
    $symbols = $SymbolHash.($number.line -1) + $SymbolHash.($number.line) + $SymbolHash.($number.line +1)

    foreach ($Item in $Numberpositions) {
        if($symbols -contains $item){
            $sum += $number.number
            break
        }
    }
}


$sum
if($sum -le 511086){"Sum is to low"}
else{"This could be right"}