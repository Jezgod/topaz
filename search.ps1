$date = Get-Date -Format G

while ($true)
{
    if ((Get-Process -Name topaz_search -ErrorAction Stop) -eq $null)
    {

        Write-Host -ForegroundColor Red "Server Is Not Running"
        <#.\topaz_search.exe -launcher -dedicated -headless -window -height 300 -width 300#>
        Start-process C:\ffxi\topaz\topaz_search
        "Guardian Started DSSearch Server $($date)" | Add-Content .\searchServer.log 
         <#Start-process C:\ffxi\topaz\topaz_search#>
  

    }
    else
    {
        write-host -ForegroundColor Green "Server Is Running"
    }

    Start-Sleep -Seconds 10
}