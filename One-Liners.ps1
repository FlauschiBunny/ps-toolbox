#Zip every File in a separate archive
Get-ChildItem * | ForEach-Object {Compress-Archive -Path $_.FullName -DestinationPath ".\$($_.BaseName).zip"}

#Rename all files that match a pattern
Get-ChildItem * | Where-Object {$_.FullName -match "\[!]"}| Rename-Item -NewName {$_.FullName -Replace "\[!]","(!)"}