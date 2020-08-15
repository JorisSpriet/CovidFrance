$url = "https://raw.githubusercontent.com/opencovid19-fr/data/master/dist/chiffres-cles.json"

$data = Invoke-RestMethod -Uri $url -Method Get -ContentType "application/json"

$ariege = $data | where-object { $_.code -eq "DEP-09"} | sort-object { $_.date }

$evolution_ariege= $ariege | select-object { "$($_.date) $('{0:d5}' -f $_.hospitalises) $('{0:d5}' -f $_.nouvellesHospitalisations)" }

$haute_garonne = $data | where-object { $_.code -eq "DEP-31"} | sort-object { $_.date }

$evolution_haute_garonne = $haute_garonne  | select-object { "$($_.date) $('{0:d5}' -f $_.hospitalises) $('{0:d5}' -f $_.nouvellesHospitalisations)" }

$data_ariege = @{}
$date_haute_garonne=@{}
$now = get-date
$start = $now.Date.AddDays(-60)
$startfilter = $start.ToString("yyyy-MM-dd")

foreach($d in $data) {
  if($d.date -lt $startfilter) { continue}
  if($d.code -ne "DEP-09" -and $d.code -ne "DEP-31") { continue}

  $point = @{}
  $point.Hospitalises = $data.hospitalises
  $point.Stijging = $data.nouvellesHospitalisations

  switch ($d.code) {
    "DEP-09" {  
      $data_ariege.Add($point)
    }
    "DEP-31"
    Default {}
  }

}
