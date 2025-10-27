$pattern = "<strong>(.*?)</strong>"
$URI = "https://wiki.piratenpartei.de/wiki/index.php?title=Spezial:Defekte_Weiterleitungen&limit=500"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 <# using TLS 1.2 is vitally important #>

$req = Invoke-Webrequest -URI $URI
$count = [regex]::Match($req.RawContent,$pattern).Groups[1].Value

if ($count -ge 0)
    {
    Write-Host Broken Redirects : $count
    Get-Date -Format "yyyyMMdd," | Out-File -FilePath '.\broken-redirects.csv' -Encoding ascii -Append -NoNewline -Force
    $count | Out-File -FilePath '.\broken-redirects.csv' -Encoding ascii -Append -Force
    }
