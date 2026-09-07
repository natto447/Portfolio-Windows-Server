Import-Module ActiveDirectory

Write-Host "`n=== INFORMAÇÕES DO DOMINIO ===" -ForegroundColor Cyan

Get-ADDomain |
    Select-Object DNSRoot, DistinguishedName, DomainMode, Forest |
    Format-List

Write-Host "`n=== DOMAIN CONTROLLER ===" -ForegroundColor Cyan

Get-ADDomainController |
    Select-Object HostName, IPv4Address, Site, Domain, Forest |
    Format-Table -AutoSize

Write-Host "`n=== UNIDADES ORGANIZACIONAIS ===" -ForegroundColor Cyan

Get-ADOrganizationalUnit -Filter * |
    Sort-Object DistinguishedName |
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize