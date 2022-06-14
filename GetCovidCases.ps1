param(
  [parameter(mandatory=$true)][string] $City,
  [parameter(mandatory=$false)][int] $Days = 14 
)

$fn = "$PWD\covid19be_cases_muni.json"
$getnewdata = $true

if(Test-Path -Path $fn) {
  $today = (Get-Date).Date
  $f = Get-Item -Path $fn
  if($f.LastWriteTime.Date -eq $today) {
    $getnewdata=$false
    $data = Get-Content -Path $fn | ConvertFrom-Json
  }
}

if($getnewdata) {
  $url = "https://epistat.sciensano.be/Data/COVID19BE_CASES_MUNI.json"
  $data = Invoke-RestMethod -Uri $url -Method Get -ContentType "application/json"
  $data | ConvertTo-Json | Set-Content -Path $fn
}

$citydata = $data | where-object { $_.TX_DESCR_NL -eq $city } | select-object
$citydata | Select-Object { [System.DateTime]::Parse($_.Date).ToString("yyyy-MM-dd ddd"), $_.Cases }