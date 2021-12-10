Write-Output "Dieses SKript funkoniert nur, wenn das NetCmdlets 2016 installiert ist. Siehe https://www.nsoftware.com/powershell/netcmdlets/download.aspx"
$uid = Read-Host  -Prompt "Who are you?" 
$PW = Read-Host "Passwort, bitte" -AsSecureString
$Server = "ldap.server.de"
$BindDN = "uid=$uid,ou=People,dc=company,dc=de"
$Filter = Read-Host "uid?"
$plainPw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($PW))
$LDAPCn = Connect-LDAP -Server $Server -Port 389 -Password $plainPW -BindDN $BindDN -Version 3 -Timeout 20

$DN = "ou=People,dc=company,dc=de"
 
Get-LDAP -Connection $LDAPCn -Search "uid=$Filter" -SearchScope wholesubtree -DN $DN
 
Disconnect-LDAP -Connection $LDAPCn
Read-Host "Press any key"
