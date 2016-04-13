function Get-PaddedCenter
{
    <#
        .SYNOPSIS
        Short Description
        .DESCRIPTION
        Detailed Description
        .EXAMPLE
        Get-PaddedCenter
        explains how to use the command
        can be multiple lines
        .EXAMPLE
        Get-PaddedCenter
        another example
        can have as many examples as you like
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0)]
        [System.String[]]
        $Title = 'Start',
        
        [Parameter(Mandatory=$false, Position=1)]
        [System.Int32]
        $Width = 100,
        
        [Parameter(Mandatory=$false, Position=2)]
        [System.String]
        $Separator = ' ',
        
        [Parameter(Mandatory=$false, Position=3)]
        [System.String]
        $Pad = '='
    )
    
    [string]$Title = [string]::Join($Separator,$Title)
    $PadLengthFull = ($Width - $Title.Length - $Separator.Length*2)
    Write-Verbose -Message "PadLengthFull: $PadLengthFull"
    $Remainder  = 0 ; $PadLength = [system.math]::DivRem($PadLengthFull,2,[ref]$Remainder)
    Write-Verbose -Message "PadLength: $PadLength"
    Write-Verbose -Message "Remainder: $Remainder"
    [string]::Join($Separator,$Pad*$PadLength,$Title,$Pad*($PadLength+$Remainder))
}