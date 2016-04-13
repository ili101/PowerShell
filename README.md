# PowerShell
PowerShell stuff

Invoke-RestMethodUTF8Post (Replaced by Invoke-RestMethod -UTF8)
Function to replace Invoke-RestMethod and Invoke-WebRequest in case the response is in UTF-8 / Unicode and you get gibberish in the non-English characters.<br>Support Xml or String imputes and outposts.

Invoke-RestMethod -UTF8
A wrapper for Invoke-RestMethod that add a switch parameter named UTF8 that decode the output as UTF-8
