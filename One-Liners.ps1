#Zip every File in a separate archive
gci * | ForEach-Object {Compress-Archive -Path $_.FullName -DestinationPath ".\$($_.BaseName).zip"}
