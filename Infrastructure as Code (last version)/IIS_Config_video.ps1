Import-Module servermanager
Add-Windowsfeature web-server -includeallsubfeature
Add-Windowsfeature Web-Asp-Net45
Add-Windowsfeature NET-Framework-Featurest
New-Item -Path "C:\inetpub\wwwroot\" -Name "videos" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\videos\Default.html" -Value "This is the video server"