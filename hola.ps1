
# function mos 
# {
#     while (1) 
#     {
#         Write-Host -NoNewline "|`b"
#         Start-Sleep -Milliseconds 600 
#         Write-Host -NoNewline "-`b"
#         Start-Sleep -Milliseconds 600  
#     }
# }

Start-Process -FilePath "D:\instaladores\optimizaMemoria\memboost\memBoost.exe" 
Start-Sleep -Seconds 14 
Start-Process -FilePath "C:\Users\casa\AppData\Local\Programs\Opera\launcher.exe" 
Start-Sleep -Seconds 10 
Start-Process -FilePath "C:\Windows\explorer.exe"
