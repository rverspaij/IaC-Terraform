Import-Module servermanager
Add-Windowsfeature web-server -includeallsubfeature
Add-Windowsfeature Web-Asp-Net45
Add-Windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "test2" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\test2\Default.html" -Value "This is the test2 server"