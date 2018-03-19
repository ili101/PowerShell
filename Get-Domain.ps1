function Get-Domain
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, Position=0)]
        [String]
        $Fqdn
    )
    
    # Create TLDs List as save it to "script" for faster next run.
    if (!$TldsList)
    {
        $TldsListRow = Invoke-RestMethod -Uri https://publicsuffix.org/list/public_suffix_list.dat
        $script:TldsList = ($TldsListRow -split "`n" | Where-Object {$_ -notlike '//*' -and $_})
        [array]::Reverse($TldsList)
    }
    #Remove-Variable TldsList

    $Ok = $false
    foreach ($Tld in $TldsList)
    {
        if ($Fqdn -Like "*.$Tld")
        {
            $Ok = $true
            break
        }
    }
    #$Tld =  $TldList | Where-Object {$Domain -Like "*.$_"} | Select-Object -Last 1

    if ($Ok)
    {
        ($Fqdn -replace "\.$Tld" -split '\.')[-1] + ".$Tld"
    }
    else
    {
        throw 'Not a valid TLD'
    }
}