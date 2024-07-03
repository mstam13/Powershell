﻿<#  
    .Synopsis  
    Convert MAC Address to IPV6.
    .Description  
    This script converts given Mac Address to IPV6.
    .Example  
    .\Convertto-IPV6.ps1 -Mac 00:00:00:00:00:00
        
    It takes provided Mac and converts to reusable IPV6 address
    
    .Notes
    NAME: Convertto-IPV6.ps1
    Version: 1.2
    AUTHOR: Kunal Udapi
    CREATIONDATE: 5 May 2017
    LASTEDIT: 14 May 2020
    KEYWORDS:Convert MAC Address to IPV6.
    .Link  
    #Check Online version: http://kunaludapi.blogspot.com (Initially written for)
    #Requires -Version 3.0  
    #>  
   ########################################################################  
   # Generated On: 5 May 2017
   # Generated By: vCloud-lab.com  
   # Tested On: last tested on Windows 10, Earlier tested on Windows 8.1
   # For any question drop an question to kunaludapi@gmail.com
   ########################################################################  

[CmdletBinding()]
param(  
    [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$true)]
    [alias('MacAddress')]
    [String]$Mac = '00:15:5D:26:42:09'
) #param

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$rawHexTable = Get-Content $scriptPath\hexTable.json 


$hexTable = $rawHexTable | ConvertFrom-Json
$insert = "{0}:ff:fe:{1}" -f $mac.Substring(0,8), $mac.Substring(9)
$splitIPV6Node = $insert -split ':'
$rawNotation = @()
for ($i=0; $i -lt $splitIPV6Node.Count; $i++) 
{
    #$splitIPV6Node[$i]
    if ([math]::Floor($i%2) -eq 0) 
    {
        $reFormat = $splitIPV6Node[$i]
    }
    else 
    {
        $reFormat += $splitIPV6Node[$i]
        $rawNotation += $reFormat
    }
}
$IPV6Notation = $rawNotation -Join ':'
$firstNodeBin = $splitIPV6Node[0].substring(0,1)
$secondNodeBin = $splitIPV6Node[0].substring(1,1)
$secondProcessedHex = $hexTable | Where-Object {$_.xHex -eq $secondNodeBin} | Select-Object -ExpandProperty yHex
$completeIPV6 = "fe80::{0}{1}{2}" -f $firstNodeBin, $secondProcessedHex,$IPV6Notation.Substring(2)
$completeIPV6