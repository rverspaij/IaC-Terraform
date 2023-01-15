Import-Module servermanager
Add-Windowsfeature web-server -includeallsubfeature
Add-Windowsfeature Web-Asp-Net45
Add-Windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "test1" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\test1\Default.html" -Value "This is the test1 server"