# task 1
$stuff = Get-Clipboard | Where-Object { $_ }
$stuffconv = $stuff | convertfrom-csv -Delimiter " " -Header "direction", "value"

$upsum = 0
$downsum = 0
$forwardsum = 0
foreach ($item in $stuffconv) {
    switch ($item.direction) {
        up { $upsum = [int]$upsum + [int]$item.value }
        down { $downsum = [int]$downsum + [int]$item.value }
        forward { $forwardsum = [int]$forwardsum + [int]$item.value }
        Default {}
    }
}
($downsum - $upsum) * $forwardsum | Set-Clipboard


# task 2
$stuff = Get-Clipboard | Where-Object { $_ }
$stuffconv = $stuff | convertfrom-csv -Delimiter " " -Header "direction", "value"
$aim = 0
$forward = 0
$depth = 0
foreach ($item in $stuffconv) {
    switch ($item.direction) {
        up { $aim = $aim - [int]$item.value }
        down { $aim = $aim + [int]$item.value }
        forward {
            $forward = $forward + [int]$item.value
            $depth = $depth + ([int]$item.value * $aim)
        }
        Default {}
    }
}
$forward * $depth | Set-Clipboard