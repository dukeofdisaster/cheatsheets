# attack methodology - lite
**TODO**: expand

You've heard it a million times before : scan, enumerate, exploit, pivot,
exfiltrate. i.e. What's there? What do I know about what's there?
Are there vulnerabilities in what's there? What can I get of value when I get in?. 

## Scanning tools
- masscan
- nmap
- unicornscan
- netdiscover

## web directory/path enum
- dirsearch.py
- dirbuster
- dirb
- gobuster
- wfuzz

## smb enum
nmap
 - use --script options
 - smb-enum-domains
 - smb-enum-groups
 - smb-enum-processes
 - smb-enum-services
 - smb-enum-sessions
 - smb-enum-shares
 - smb-enum-users

smbclient
  - lists smb shares on target
  - -L //10.10.10.10 -U ""
  - 

smbmap
 - basically same as smbclient; 
 - -H 10.10.10.10 -u someusernampe -p somepassword -L 
