#requires -Version 2

function Get-Tail
{
    <#
            .SYNOPSIS
            Tail command
            .DESCRIPTION
            Can tail files and wait on multiple files unlike Get-Content -Wait
            .PARAMETER Path
            Paths to log files
            .PARAMETER Tail
            number of lines to tail (0 for none)
            .PARAMETER RefreshRate
            Refresh interval
            .PARAMETER Filter
            Filter text -like format, * whildcard
            .PARAMETER Wait
            Waits for more output, end with Ctrl + C
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, Position = 0,ValueFromPipeline = $true)]
        [string[]]$Path,

        [Parameter(Position = 1)]
        [Int32]$Tail = 10,

        [Parameter(Position = 2)]
        [Int32]$RefreshRate = 100,

        [Parameter(Position = 3)]
        [string]$Filter,

        [Parameter(Position = 3)]
        [switch]$Wait

    )
    
    #check if pipeline or path variable
    if ($Input)
    {
        [string[]]$Paths = @($Input)
    }
    else
    {
        $Paths = $Path
    }

    #create Readers
    $Files = @{}
    foreach ($Path in $Paths)
    {
        $Reader = New-Object -TypeName System.IO.StreamReader -ArgumentList (New-Object -TypeName IO.FileStream -ArgumentList ($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, ([IO.FileShare]::Delete,([IO.FileShare]::ReadWrite)) ))
        #get end the file
        $LastMaxOffset = $Reader.BaseStream.Length
        #get encoding
        $null = $Reader.Readline()
        $Reader.DiscardBufferedData()
        #seek to the last max offset
        $null = $Reader.BaseStream.Seek($LastMaxOffset, [System.IO.SeekOrigin]::Begin)
      
        $Files.Add($Path, (New-Object -TypeName PSObject -Property (@{
                        'Reader'      = $Reader
                        'LastMaxOffset' = $LastMaxOffset
        })))
    }
    
    #tail existing lines
    if ($Tail -gt 0)
    {
        foreach ($Path in $Paths)
        {
            Write-Host -ForegroundColor Green -Object $Path
            if ($PSVersionTable.PSVersion.Major -gt 2)
            {
                Get-Content -Path $Path -Tail $Tail | foreach {if (!$Filter -or $_ -like $Filter) {$_}}
            }
            else
            {
                Write-Warning -Message 'Tail option can be slow on PowerShell 2.0 set Tail to 0 to disable it'
                Get-Content $Path | Select-Object -Last $Tail | foreach {if (!$Filter -or $_ -like $Filter) {$_}}
            }
        }
        $LastFile = $Path
    }
    else
    {
        $LastFile = $null
    }
    
    #tail new lines
    if ($Wait)
    {
        :ReaderLoop while ($true)
        {
            Start-Sleep -Milliseconds $RefreshRate
            foreach ($File in $Files.GetEnumerator())
            {
                #if the file size has not changed, idle
                if ($File.Value.Reader.BaseStream.Length -eq $File.Value.LastMaxOffset)
                {
                    continue
                }
                
                if ($LastFile -ne $File.name)
                {
                    Write-Host -ForegroundColor Green -Object $File.name
                    $LastFile = $File.name
                }
                
                #read out of the file until the EOF
                while (($Line = $File.Value.Reader.ReadLine()) -ne $null)
                {
                    if (!$Filter -or $Line -like $Filter)
                    {
                        $Line
                    }
                }
                #update the last max offset
                $File.Value.LastMaxOffset = $File.Value.Reader.BaseStream.Position
            }
        }
    }
}

<#
        Get-Tail -Path C:\Windows\WindowsUpdate.log,C:\Windows\win.ini
        Get-ChildItem -Path C:\Windows\win.ini,C:\Windows\*.log -Exclude PFRO.log | Get-Tail -Tail 5 -Filter *and* -Wait
#>