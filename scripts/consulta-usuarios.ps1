Import-Module ActiveDirectory

Write-Host "=== USUÁRIOS DO DOMÍNIO ===" -ForegroundColor Cyan

Get-ADUser -Filter * -Properties Enabled |
    Sort-Object Name |
    Select-Object Name, SamAccountName, Enabled, DistinguishedName |
    Format-Table -AutoSize