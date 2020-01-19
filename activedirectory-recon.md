# Domain Recon with Powershell
## landed on a box connected to a domain, now what?
- Can the user add other users?
net user mynewuser myuserspassword /add

- Can the user be added to local admins?
net localgroup Administrators mynewuser /add

- Can user be added to Remote Management Users to login via winrm?
net localgroup "Remote Management Users" mynewuser /add

- Use powershell builtin's to get current forrest info
PS C:\Users\myuser\Documents> [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()


Name                  : htb.local
Sites                 : {Default-First-Site-Name}
Domains               : {htb.local}
GlobalCatalogs        : {FOREST.htb.local}
ApplicationPartitions : {DC=DomainDnsZones,DC=htb,DC=local, DC=ForestDnsZones,DC=htb,DC=local}
ForestModeLevel       : 7
ForestMode            : Unknown
RootDomain            : htb.local
Schema                : CN=Schema,CN=Configuration,DC=htb,DC=local
SchemaRoleOwner       : FOREST.htb.local
NamingRoleOwner       : FOREST.htb.local


- GetCurrentDomain()
PS C:\Users\svc-alfresco\Documents> [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()


Forest                  : htb.local
DomainControllers       : {FOREST.htb.local}
Children                : {}
DomainMode              : Unknown
DomainModeLevel         : 7
Parent                  : 
PdcRoleOwner            : FOREST.htb.local
RidRoleOwner            : FOREST.htb.local
InfrastructureRoleOwner : FOREST.htb.local
Name                    : htb.local

- Get forest trusts
PS C:\Users\svc-alfresco\Documents> $ForestRootDomain = 'htb.local'
PS C:\Users\svc-alfresco\Documents> ([System.DirectoryServices.ActiveDirectory.Forest]::GetForest((New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest',$ForestRootDomain)))).GetAllTrustRelationships()
 
- Domain Trusts
PS C:\Users\svc-alfresco\Documents> ([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()

- discover enterprise services, discovering service princpal names
PS C:\Users\svc-alfresco\Documents> get-adcomputer -filter {ServicePrincipalName -like "*TERMSRV*" } -Propertie OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation


DistinguishedName          : CN=FOREST,OU=Domain Controllers,DC=htb,DC=local
DNSHostName                : FOREST.htb.local
Enabled                    : True
LastLogonDate              : 1/12/2020 6:05:58 PM
Name                       : FOREST
ObjectClass                : computer
ObjectGUID                 : 0b814a2b-18eb-4f6a-9449-3387cf40b27a
OperatingSystem            : Windows Server 2016 Standard
OperatingSystemServicePack : 
OperatingSystemVersion     : 10.0 (14393)
PasswordLastSet            : 1/12/2020 6:05:34 PM
SamAccountName             : FOREST$
ServicePrincipalName       : {TERMSRV/FOREST, TERMSRV/FOREST.htb.local, exchangeAB/FOREST, exchangeAB/FOREST.htb.local...}
SID                        : S-1-5-21-3072663084-364016917-1341370565-1000
TrustedForDelegation       : True
TrustedToAuthForDelegation : False
UserPrincipalName          : 


