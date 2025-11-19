[Hashtable]$ToDo = @{
    'broken-redirects.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Defekte_Weiterleitungen&limit=5000'
    'double-redirects.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Doppelte_Weiterleitungen&limit=5000'
    'wished-files.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Gew%C3%BCnschte_Dateien&limit=5000'
    'wished-categories.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Gew%C3%BCnschte_Kategorien&limit=5000'
    #'wished-sites.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Gew%C3%BCnschte_Seiten&limit=5000'
    'wished-templates.csv' = 'https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Gew%C3%BCnschte_Vorlagen&limit=5000'
    }

$pattern = "<strong>(.*?)</strong>"

$ToDo.keys | foreach-object {
    $File = $_
    $URI = $ToDo.$File

    Write-Host Check Site : $URI

    $req = Invoke-Webrequest -URI $URI

    $count = [regex]::Match($req.RawContent,$pattern).Groups[1].Value

    if ($count -ge 0)
        {
        Write-Host Value : $count
        Get-Date -Format "yyyyMMdd," | Out-File -FilePath $File -Encoding ascii -Append -NoNewline -Force
        $count | Out-File -FilePath $File -Encoding ascii -Append -Force
        }
    else
        {
        Write-Host Not higher than zero : $count
        Write-Host $req.RawContent
        }
    }
