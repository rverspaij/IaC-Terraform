import-module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature Web-Asp-Net45
add-windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "test1" -ItemType "directory"
Set-Content -Path "C:\inetpub\wwwroot\test1\Default.html" -Value "This is the test1 server"