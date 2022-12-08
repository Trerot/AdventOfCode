$sampleset = @"
30373
25512
65332
33549
35390
"@

# create an arraylist with all the trees and shit.
$arraylist = new-object -TypeName System.Collections.ArrayList
$columncounter = 0
$rowcounter = 0
for ($i = 0; $i -lt $sampleset.ToCharArray().Count; $i++) {
    if ($sampleset.Tochararray()[$i] -eq $sampleset.ToCharArray()[5]) {
        $i += 2
        $columncounter ++
        $rowcounter = 0
    }
    else {
        $arraylist.Add(
            [PSCustomObject]@{
                Column  = $columncounter
                Row     = $rowcounter
                height  = $sampleset.Tochararray()[$i]
                visible = $null
            }
        )
        $rowcounter++
    }
}
$arraylist