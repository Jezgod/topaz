$date = Get-Date -Format G

while ($true)
{
    if ((Get-Process -Name topaz_connect -ErrorAction SilentlyContinue) -eq $null)
    {

        Write-Host -ForegroundColor Red "Server Is Not Running"
        <#.\topaz_connect.exe -launcher -dedicated -headless -window -height 300 -width 300#>
        Start-process C:\ffxi\topaz\topaz_connect
        "Guardian Started DSConnect Server $($date)" | Add-Content .\connectServer.log 
         <#Start-process C:\ffxi\topaz\topaz_connect#>
  

    }
    else
    {
        write-host -ForegroundColor Green "Server Is Running"
    }

    Start-Sleep -Seconds 10
}