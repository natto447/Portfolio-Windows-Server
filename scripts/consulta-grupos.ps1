Import-Module ActiveDirectory

Write-Host "=== GRUPOS DO DOMÍNIO ===" -ForegroundColor Cyan

Get-ADGroup -Filter * |
    Sort-Object Name |
    Select-Object Name, GroupScope, GroupCategory, DistinguishedName |
    Format-Table -AutoSize

Write-Host "`n=== MEMBROS DOS GRUPOS ===" -ForegroundColor Yellow

Get-ADGroup -Filter * | ForEach-Object {

    Write-Host "`nGrupo: $($_.Name)" -ForegroundColor Green

    Get-ADGroupMember -Identity $_.Name -ErrorAction SilentlyContinue |
        Select-Object Name, ObjectClass |
        Format-Table -AutoSize
}