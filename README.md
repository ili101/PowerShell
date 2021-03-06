﻿
# PowerShell
PowerShell stuff

## Contributing
If you fund a bug or added functionality or anything else just fork and send pull requests. Thank you!

## Join-Object (Beta)
Join-Object LINQ Edition.
Aims to provide the exact functibility of https://github.com/RamblingCookieMonster/PowerShell/blob/master/Join-Object.ps1 with much better performance.
Initial testing shows at last 100 times faster.

See https://github.com/ili101/Join-Object

# Split-MotionPhoto
Split Samsung combo Motion Photo files (JPG) to separate JPG and MP4 files

See https://github.com/ili101/Split-MotionPhoto

## Invoke-RestMethod -UTF8
A wrapper for Invoke-RestMethod that add a switch parameter named UTF8 that decode the output as UTF-8<br>
In case the response is in UTF-8 / Unicode and you get gibberish in the non-English characters.<br>Support Xml or String imputes and outposts.
<br>Invoke-RestMethodUTF8Post (Replaced by Invoke-RestMethod -UTF8)

## Get-PaddedCenter
Pad the text from left and right
##### Examples:
```PowerShell
Get-PaddedCenter
============================================== Start ===============================================
```
```PowerShell
Get-PaddedCenter -Title 'End',(Get-Date)
===================================== End 04/13/2016 17:19:10 ======================================
```
```PowerShell
Get-PaddedCenter -Title 'Test' -Separator $null -Width 8 -Pad ([char]35)
##Test##
```

## Get-Tail
tail files and waits, support multiple files unlike Get-Content -Wait
##### Examples
```PowerShell
Get-Tail -Path C:\Windows\WindowsUpdate.log,C:\Windows\win.ini
Get-ChildItem -Path C:\Windows\win.ini,C:\Windows\*.log -Exclude PFRO.log | Get-Tail -Tail 5 -wait
```
![](https://raw.githubusercontent.com/ili101/PowerShell/master/Examples/Example1.png)
