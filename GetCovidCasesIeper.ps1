$url = "https://epistat.sciensano.be/Data/COVID19BE_CASES_MUNI.json"
$data = Invoke-RestMethod -Uri $url -Method Get -ContentType "application/json"
$ieper = $data | where-object { $_.TX_DESCR_NL -eq "Ieper" } | select-object
$ieper | Select-Object { [System.DateTime]::Parse($_.Date).ToString("yyyy-MM-dd ddd"), $_.Cases }