# Import the Active Directory module for the Get-ADComputer CmdLet
Import-Module ActiveDirectory

# Get all domain-joined computers
$computers = Get-ADComputer -Filter * -Properties *

# Loop through computers
foreach ($computer in $computers) {
    # Get the last logon time
    $lastLogon = $computer.LastLogonTimestamp

    # If the last logon time is not 0, convert it to a readable time
    if ($lastLogon -ne 0) {
        $dt = [DateTime]::FromFileTime($lastLogon)
    } else {
        $dt = $null
    }

    # Output the computer name and last logon time to CSV
    $computer | Select-Object Name, DistinguishedName, Enabled, @{Name="Stamp"; Expression={$dt}} | Export-Csv -Path "C:\temp\lastlogon.csv" -NoTypeInformation -Append
}
```