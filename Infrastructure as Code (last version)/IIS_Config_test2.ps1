import-module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature Web-Asp-Net45
add-windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "test2" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\test2\Default.html" -Value "This is the test2 server"