#
# Title: Generic Reboot Script
# Version: 1.0.0
# Date: 08/14/2015
# Author: Neojosh28
#

#Sets Execution Policy and variable to be passed to function
set-executionpolicy remotesigned -force
$Hostnames = get-content C:\users\jlafave\GIT\newb-reboot\Servers.txt
     


#Sets a Loop through the Array 
Foreach ($HostName in $HostNames)
{
     $Continue = $True

    Try

    {
         Test-Connection -ComputerName $hostname -count 1 -Quiet
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


#TEST Availability and sends email based on test results
Get-Content c:\users\jlafave\git\newb-reboot\servers.txt | foreach { 

    if (-not (Test-Connection -ComputerName $_ -count 1 -Quiet)) 
        
       {
        #Sets Value for Reboot Confirmation
        $emailSmtpServer = "mail.autopartintl.com"
        $emailFrom = "Administrator <Administrator2@autopartintl.com>"
        $emailTo = "josh.lafave@autopartintl.com"
        $emailSubject = "Aconnex Server $_ Reboot Failed"
        $emailBody = "Please check Aconnex server for status."

        #Sends Email to dl-OPSITS@autopartintl.com
        Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
       } 

    else 
       {
        $emailSmtpServer = "mail.autopartintl.com"
        $emailFrom = "Administrator <Administrator2@autopartintl.com>"
        $emailTo = "josh.lafave@autopartintl.com"
        $emailSubject = "Success!! Aconnex Server $_"
        $emailBody = "Reboot completed successfully."

        #Sends Email to dl-OPSIT@autopartintl.com
        Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
       }
        
}



