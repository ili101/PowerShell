    # Function to help post HTTP request to web service
    Function Invoke-RestMethodUTF8Post
    {    
        param
        (
            [parameter(Mandatory = $True)][String]$Uri,
            [ValidateScript({$_.GetType().Name -in 'XmlDocument', 'XmlElement', 'String'})]$Body,
            [int] $TimeoutSec = -1
        )
        if ($Body.GetType().Name -in 'XmlDocument', 'XmlElement')
        {
            $Body = $Body.InnerXml
        }
    
        $Buffer = [System.Text.Encoding]::UTF8.GetBytes($Body)
        [System.Net.HttpWebRequest] $WebRequest = [System.Net.WebRequest]::Create($Uri)
        if ($TimeoutSec -ge 0)
        {
            $TimeoutSec = $TimeoutSec * 1000
            $WebRequest.Timeout = $TimeoutSec
        }
        $WebRequest.Method = 'POST'
        $WebRequest.ContentType = 'application/x-www-form-urlencoded'
        $WebRequest.ContentLength = $Buffer.Length
    
        $RequestStream = $WebRequest.GetRequestStream()
        $RequestStream.Write($Buffer, 0, $Buffer.Length)
        $RequestStream.Flush()
        $RequestStream.Close()
    
        [System.Net.HttpWebResponse] $WebResponse = $WebRequest.GetResponse()
        Write-Verbose -Message ('WebResponse: ' + ($WebResponse | Out-String))
        $streamReader = New-Object -TypeName System.IO.StreamReader -ArgumentList ($WebResponse.GetResponseStream())
        $Result = $streamReader.ReadToEnd()
    
        if ($Result.StartsWith('<?xml version="1.0"'))
        {
            $Result = [xml]$Result
        }
    
        return $Result
    }

$Url = 'http://example.com:80'
[Xml]$Xml = '<?xml version="1.0" encoding="UTF-8"?><example><example2>example3</example2></example>'

$Result = Invoke-RestMethodUTF8Post -Uri $Url -Body $xml -Verbose
$Result
#$Result.InnerXml
