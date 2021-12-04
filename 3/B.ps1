# Usage: pwsh B.ps1 inputfilename
Param(
    [Parameter(Mandatory=$true)]
    [string]
    $FileName
)

$data = get-content -Path $FileName

# Find matching entries
function get-matchstr ($x, $y, $sdata) {
    $found = 0
    $strlen = 1
    $subdata = $sdata
    $str = ""
    while  (! $found){
        $dv = get-distribution ($strlen - 1) $subdata
        $ln = $subdata.Length
        $dx = $ln - $dv
#        write-host "POS val = $dv of $ln"
#        write-host "DV= $dv, X= $x, DX = $dx  Str: " -NoNewline
        if       (($x -eq '1') -and ($dv -ge ($dx))) {
            $str += "$x"
#            write-host -NoNewline $x + " Regexp: "
        } elseif (($x -eq '1') -and ($dv -lt ($dx))) {
            $str += "$y"
#            write-host -NoNewline $y + " Regexp: "
        } elseif (($x -eq '0') -and ($dv -ge ($dx))) {
            $str += "$x"
#            write-host -NoNewline $x + " Regexp: "
        } elseif (($x -eq '0') -and ($dv -lt ($dx))) {
            $str += "$y"
#            write-host -NoNewline $y + " Regexp: "
        } else {
            $str += "-"
        }           
#        Write-Host $str
        $subdata = ($subdata -match "^$str")
        if ($subdata.Length -eq 1) {
            $found = 1
            $subdata;

        } elseif (! $subdata) {
            Write-host "Error, no data matching pattern"
            break
        } else {
            $strlen++
        }
        $dv = get-distribution ($strlen -1) $subdata
#        write-host "$grep search resulted in nbr of hits: " $subdata.Length
    }
}

# Calculate distribution of 1 and 0
function get-distribution ($pos, $listdata) {
    $values = 0
    $ln = 0

    # calculate number of 1:s in each position
    foreach ($line in $listdata) {
        $ln++
        $chars = $line.ToCharArray()
        if ($chars[$pos] -eq '1') {
            $values++
        }
    }
    return  $values;
}

# Complex logic here, depending on whether we look for oxygen or co2 debug strings in input
$ores = get-matchstr '1' '0' $data
$cres = get-matchstr '0' '1' $data

$oxy = [convert]::ToInt32($ores,2)
$co2 = [convert]::ToInt32($cres,2)

write-host "Oxygen: $ores ($oxy) CO2: $cres ($co2) and life rating " + ($oxy * $co2)

