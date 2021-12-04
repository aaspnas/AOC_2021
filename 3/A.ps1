# Usage: pwsh A.ps1 inputfilename
Param(
    [Parameter(Mandatory=$true)]
    [string]
    $FileName
)

$data = get-content -Path $FileName

$datalength = (Get-Content -tail 1 -Path ./input.txt).length

$values = @()

# Initialize value array
for ($v=0; $v -lt $datalength; $v++) {
    $values += 0;
}
$linenumber = 0

# calculate number of 1:s in each position
foreach ($line in $data) {
    $linenumber++
    $chars = $line.ToCharArray()
    for ($c=0; $c -lt $chars.length; $c++) {
        if ($chars[$c] -eq '1') {
            $values[$c]++
        }
    }
}
# Obtain gamma and epsilon
$gammastr = ""
$epsilonstr = ""
foreach ($v in $values) {
    if ($v -gt ($linenumber/2)) {
        $gammastr += "1"
        $epsilonstr += "0"
    } else {
        $gammastr += "0"
        $epsilonstr += "1"
    }
}
$gamma = [convert]::ToInt32($gammastr,2)
$epsilon = [convert]::ToInt32($epsilonstr,2)

Write-Host "Gamma = $gamma and epsilon = $epsilon and Result = " + ($gamma * $epsilon)