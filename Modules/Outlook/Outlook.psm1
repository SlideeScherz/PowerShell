# Outlook.psm1
# PowerShell module for Outlook functions

# refs:
# basic example: https://stackoverflow.com/questions/73778957/how-do-you-create-an-outlook-appointment-meeting-in-powershell
# all available configuration params on outlook object: https://community.spiceworks.com/t/powershell-script-to-create-new-outlook-meeting/717747
# more "modern" example and usage: https://www.powershellgallery.com/packages/PSPrompt/0.4.4/Content/functions%5CNew-OutlookCalendar.ps1

# changelog
# 1.0.0 init
# 1.0.1 Added functionality for "Show as"
# 1.0.2 fixed off by 1 min bug by adding 0 seconds to each date param
# 1.1.0 Added script params and removed invocations
# 1.2.0 Refactored into module with helper function for date handling

function New-OutlookAppointment {
    [CmdletBinding()]
    param (
        # todo: [Parameter(Mandatory = $true)][String]$Outlook,
        [Parameter(Mandatory = $true)][String]$Subject,
        [Parameter(Mandatory = $true)][DateTime]$MeetingStart,
        [Parameter()][String]$Categories,
        [Parameter()][String]$Location,
        [Parameter()][String]$Body = $Subject,
        [Parameter()][ValidateRange(0, 1440)][int]$ReminderMinutesBeforeStart = 15,
        [Parameter()][ValidateRange(1, 1440)][int]$DurationInMinutes = 30,
        [Parameter()][ValidateSet("Free", "Tentative", "Busy", "OutOfOffice")][string]$BusyStatus = "Busy"
    )

    $Outlook = New-Object -ComObject Outlook.Application
    $ItemType = [Microsoft.Office.Interop.Outlook.OlItemType]::olAppointmentItem
    $Appointment = $Outlook.CreateItem($ItemType)

    # ALL olAppointmentItem props
    # https://learn.microsoft.com/en-us/office/vba/api/outlook.appointmentitem#methods

    # param mapping to outlook object
    $Appointment.Subject = $Subject
    $Appointment.Body = $Body
    $Appointment.Start = "$(Get-Date $MeetingStart)"
    $Appointment.Duration = $DurationInMinutes
    # this is the outlook "Show As" status. 0 = Free, 1 = Tentative, 2 = Busy, 3 = Out of Office
    $Appointment.BusyStatus = 2

    # ======= optional params =======
    if ($ReminderMinutesBeforeStart -gt 0) {
        $Appointment.ReminderSet = $true
        $Appointment.ReminderMinutesBeforeStart = $ReminderMinutesBeforeStart
    }

    if ($PSBoundParameters.ContainsKey('Location')) {
        $Appointment.Location = $Location
    }

    if ($PSBoundParameters.ContainsKey('Categories')) {
        $Appointment.Categories = $Categories
    }
   
    Write-Host "Saving Appointment: $($Appointment.Subject) - Start Time: $($Appointment.Start)" -ForegroundColor Blue

    $Appointment.Save()
    $Appointment | Out-File -FilePath ".\Appointments\$Subject.txt" -Force
}

# Helper function to combine a date with a time string
function Get-MeetingTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][DateTime]$Date,
        [Parameter(Mandatory = $true)][string]$Time
    )
    return $Date.Date + [TimeSpan]::Parse($Time)
}

Export-ModuleMember -Function New-OutlookAppointment, Get-MeetingTime
