#
# Title: Generic Reboot Script
# Version: 1.0.0
# Date: 08/14/2015
# Author: Neojosh28
#

#Sets Execution Policy and variable to be passed to function
set-executionpolicy remotesigned -force
$Hostnames = @("jlafave_lt")
$date = Get-Date     


#Sets a Loop through the Array 
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

                     
}

#Pauses Execution for 2 minutes
Start-Sleep -Seconds 120


#Tests Server Availability
$uptime = Foreach ($hostname in $Hostnames)
{
     Test-Connection -ComputerName $hostname -Count 1
}


#Sets Valiable for Reboot Confirmation
$emailSmtpServer = "mail.autopartintl.com"
$emailFrom = "Administrator <Administrator2@autopartintl.com>"
$emailTo = "josh.lafave@autopartintl.com"
$emailSubject = "Aconnex Server Reboot Status"
$emailBody = "
Aconnex servers have been rebooted.



$uptime
"

#Sends Email to dl-OPSITS@autopartintl.com
Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
