Import-Module servermanager
Add-Windowsfeature web-server -includeallsubfeature
Add-Windowsfeature Web-Asp-Net45
Add-Windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "images" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\images\Default.html" -Value "This is the images server"