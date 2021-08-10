# USEFUL LDAPSEARCH COMMANDS
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -w 
Summer2017 -b dc=lab,dc=ropnop,dc=com "(objectClass=user)" sAMAccountName
userPrincipalName memberOf | tee domain_users.lst
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -w 
Summer2017 -b dc=lab,dc=ropnop,dc=com "(objectClass=group)" sAMAccountName member 
memberOf | tee domain_groups.lst
```

```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -w 
Summer2017 -b dc=lab,dc=ropnop,dc=com "(objectClass=computer)" name dNSHostname
operatingSystem operatingSystemVersion lastLogonTimestamp servicePrincipalName | tee 
domain_computers.lst
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -w 
Summer2017 -b dc=lab,dc=ropnop,dc=com 
"(&(objectClass=user)(memberof:1.2.840.113556.1.4.1941:=CN=Domain 
Admins,CN=Users,DC=LAB,DC=ROPNOP,DC=COM))"
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -W -b 
"dc=lab,dc=ropnop,dc=com“ 
"(&(&(servicePrincipalName=*)(UserAccountControl:1.2.840.113556.1.4.803:=512))(!(Us
erAccountControl:1.2.840.113556.1.4.803:=2)))"
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -W -b 
"dc=lab,dc=ropnop,dc=com" 
"(&(&(objectCategory=person)(objectClass=user))(userAccountControl:1.2.840.113556.1.4.803:=
524288))"
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -W -b 
"dc=lab,dc=ropnop,dc=com" 
"(&(objectCategory=computer)(objectClass=computer)(userAccountControl:1.2.840.113556.1.4.803:=524288))"
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -W -b 
"dc=lab,dc=ropnop,dc=com“ 
"(&(objectCategory=computer)(objectClass=computer)(userAccountControl:1.2.840.113556.1.4.803:=16777216))"
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -w 
Summer2017 -b 
dc=lab,dc=ropnop,dc=com "objectClass=groupPolicyContainer" displayName gPCFileSysPath
```
```
ldapsearch -LLL -x -H ldap://pdc01.lab.ropnop.com -D "thoffman@lab.ropnop.com" -W -b 
"dc=lab,dc=ropnop,dc=com" "servicePrincipalName=*" sAMAccountName servicePrincipalName
```

Enumerate groups of a user
```
ldapsearch -xLLL -h some-domaincontroller01 -D currentuser@somecompany.com -w 'currentuserpassword' -b 'dc=somecompany,dc=COM' "(samaccountname=sometargetuser)" memberOf | grep -i memberof
```
