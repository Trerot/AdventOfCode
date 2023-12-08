$stuff = get-content .\2023\Powershell\Day8\puzzleinput.txt

# fill elementhash to quickly get L or R move.
# a Nodes is all  *A
# lrmoves is all lrmoves.. 

$aNodes = New-Object -TypeName System.Collections.ArrayList
$lrmoves = $stuff[0].ToCharArray()
$ElementHash = @{}
foreach ($element in $stuff[2..($stuff.count)]) {
    $name, $leftright = $element -replace ' ' -split '='
    $left, $right = $leftright -replace '[()]' -split ','
    $ElementHash.Add(
        $name, [PSCustomObject]@{
            L = $left
            R = $right
        }
    )
    if ($name -like '*A') {
        [void]$aNodes.add($name)
    }
}
#now find count between the A to the Z
$Costs = [System.Collections.Concurrent.ConcurrentBag[psobject]]::new()
$aNodes | Foreach-Object -ThrottleLimit $anodes.Count -Parallel {
    $costs = $using:costs
    $ElementHash = $using:elementhash
    $lrmoves = $using:lrmoves
    $move = $_
    $movecounter = 0
    while ($move -notlike '*z') {
        foreach ($lr in $lrmoves) {
            $move = $ElementHash.$move.$lr
            $movecounter++
            if ($move -like '*z') {
                $costs.add($movecounter)
                break
            }  
        }
    } 
}
# this is just stack exchange https://stackoverflow.com/questions/62673868/how-do-i-create-a-function-for-finding-the-least-common-multiple-of-a-vector-of
# function for least common denominator. no clue why its so long. but it worked. 
Function Find-LCD {
    PARAM (
        [Parameter (ValueFromPipeline = $true)]
        [System.String]$String,
        [System.Double]$Number
    )
    $array = @()
    [System.Double]$product = 1
    $Numbers = $String.Split(",")
    foreach ($Number in $Numbers) {
        $sqrt = [math]::sqrt($number)
        $Factor = 2
        $count = 0
        while (($Number % $Factor) -eq 0) {
            $count += 1
            $Number = $Number / $Factor
            if (($array | Where-Object { $_ -eq $Factor }).count -lt $count) {
                $array += $Factor
            }
        }
        $count = 0
        $Factor = 3
        while ($Factor -le $sqrt) {
            while (($Number % $Factor) -eq 0) {
                $count += 1
                $Number = $Number / $Factor
                if (($array | Where-Object { $_ -eq $Factor }).count -lt $count) {
                    $array += $Factor
                }
            }
            $Factor += 2
            $count = 0
        }
        if ($array -notcontains $Number) {
            $array += $Number
        }
    }
    foreach ($arra in $array) {
        $product = $product * $arra
    }
    $product
}
# feed it a string and voila
Find-LCD -string "$($costs-join ',')"