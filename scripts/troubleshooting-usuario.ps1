Import-Module ActiveDirectory

$Usuario = Read-Host "Digite o login do usuário"

Write-Host "`n=== DIAGNÓSTICO DO USUÁRIO ===" -ForegroundColor Cyan

$User = Get-ADUser -Identity $Usuario -Properties Enabled, LockedOut, PasswordExpired, LastLogonDate

Write-Host "`nNome: $($User.Name)"
Write-Host "Login: $($User.SamAccountName)"
Write-Host "Conta habilitada: $($User.Enabled)"
Write-Host "Conta bloqueada: $($User.LockedOut)"
Write-Host "Senha expirada: $($User.PasswordExpired)"
Write-Host "Último logon: $($User.LastLogonDate)"

Write-Host "`n=== GRUPOS DO USUÁRIO ===" -ForegroundColor Cyan

Get-ADPrincipalGroupMembership $Usuario |
    Select-Object Name |
    Sort-Object Name