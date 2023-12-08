$stuff = get-content .\2023\Powershell\Day8\puzzleinput.txt

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
}

# i tried bruteforcing for 30 mins, this is in years or somethnig like that.
# number is supposedly very large. so bruteforce not available, need some clever way.

# im thinking. for each path, find amount of moves between each '*z' and if it loops perfectly someplace,


# then foreachpath, add these Z steps up until they reach an equilibrium.

