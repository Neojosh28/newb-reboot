#
# Title: Generic Reboot Script
# Version: 1.0.0
# Date: 08/14/2015
# Author: Neojosh28
#

#Sets Execution Policy and variable to be passed to function
set-executionpolicy remotesigned -force


#Sets Value for Email message
$emailSmtpServer = "SMTP of Mail Server"
$emailFrom = "From Address"
$emailTo = "To Address"
$emailSubject = ""
$emailBody = ""

Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer

$hostnames= "FQDN of Server or Servers Sperated with A comma"

Start-Sleep -Seconds 1800

Foreach ($HostName in $HostNames)
{
     $Continue = $True

   if (-not (Test-Connection -ComputerName $hostname -count 1 -Quiet)) 
             
                {
                $continue = $False
                #Sets Value for Reboot Confirmation Change as Needed
                $emailSmtpServer = ""
                $emailFrom = ""
                $emailTo = ""
                $emailSubject = "$hostname Reboot Failed"
                $emailBody = "$hostname is not online to respond to reboot request."

                #Sends Email
                Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer

                } 

   else 
                {
                   restart-computer -computername $hostname -force
                }

                     
}


Start-Sleep -Seconds 900

Foreach ($HostName in $HostNames)
{
if (-not (Test-Connection -ComputerName $hostname -count 1 -Quiet)) 
        
       {
        #Sets Value for Reboot Confirmation Change as Needed
        $emailSmtpServer = ""
        $emailFrom = ""
        $emailTo = ""
        $emailSubject = "$hostname Did Not Respond Verify Cause"
        $emailBody = "$hostname did not restart correctly."

        #Sends Email
        Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
       } 
      else 
       {
        $emailSmtpServer = ""
        $emailFrom = ""
        $emailTo = ""
        $emailSubject = ""
        $emailBody = ""
        #Sets Value for Email message
        Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
       }
}



