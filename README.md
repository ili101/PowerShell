# PowerShell
PowerShell stuff

## Invoke-RestMethod -UTF8
A wrapper for Invoke-RestMethod that add a switch parameter named UTF8 that decode the output as UTF-8

##### Invoke-RestMethodUTF8Post (Replaced by Invoke-RestMethod -UTF8)
Function to replace Invoke-RestMethod and Invoke-WebRequest in case the response is in UTF-8 / Unicode and you get gibberish in the non-English characters.<br>Support Xml or String imputes and outposts.

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
