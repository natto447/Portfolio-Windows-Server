Write-Host "======================================" -ForegroundColor Cyan
Write-Host "          DIAGNÓSTICO DE REDE         " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

Write-Host "`n=== HOSTNAME ===" -ForegroundColor Yellow

hostname

Write-Host "`n=== CONFIGURAÇÃO DE REDE ===" -ForegroundColor Yellow

Get-NetIPConfiguration |
    Select-Object InterfaceAlias,
                  IPv4Address,
                  IPv4DefaultGateway,
                  DNSServer |
    Format-List

Write-Host "`n=== TESTE DE CONECTIVIDADE COM SERVIDORWIN ===" -ForegroundColor Yellow

Test-Connection  -Count 4

Write-Host "`n=== TESTE DE DNS ===" -ForegroundColor Yellow

Resolve-DnsName empresa.local

Write-Host "`n=== TESTE DE COMUNICAÇÃO COM O DNS ===" -ForegroundColor Yellow

Test-NetConnection SERVIDORWIN -Port 53

Write-Host "`n=== TESTE DE COMUNICAÇÃO COM LDAP ===" -ForegroundColor Yellow

Test-NetConnection SERVIDORWIN -Port 389

Write-Host "`n=== DIAGNÓSTICO FINALIZADO ===" -ForegroundColor Green