

Function Reboot {
 
 # Script Variables

    [CmdLetBinding()]

    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string[]]$HostNames,
        [string[]]$date)
        


           
BEGIN {
       Write-Output "Starting Reboot Environment $date"
      }

PROCESS {
    Foreach ($HostName in $HostNames)
{
    $Continue = $True

Try

{
        Get-WmiObject –class Win32_OperatingSystem –computername $hostname
}
     
    Catch 

    {
    $continue = $False
        Write-host "Unable to Reboot $hostname"
    } 

    if ($continue) 
    {
        restart-computer -computername $hostname -force
    }

                     
    } # Closes Try
    } # Close Process    
}# Function Close


        
   


