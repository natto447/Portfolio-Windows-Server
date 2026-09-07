Import-Module ActiveDirectory

Write-Host "=== COMPUTADORES DO DOMÍNIO ===" -ForegroundColor Cyan

Get-ADComputer -Filter * -Properties OperatingSystem |
    Sort-Object Name |
    Select-Object Name, OperatingSystem, Enabled, DistinguishedName |
    Format-Table -AutoSize