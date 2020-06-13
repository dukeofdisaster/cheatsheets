# SMB enum methods
Found port 44f? List shares
$ smbclient -L //10.10.10,10

## Found shares? 
Try to connect to eaach
$ smbcliet //10.10.10.10/Data$

## Wanna just grab it all?
recurse ON
prompt OFF
mget *


## connect to target with creds using powershell
PS C:\Users\boxuser> net use \\10.10.10.178\Users /user:c.smith SomePasswordHere
The command completed successfully.

## delete the shared drive
PS C:\Users\boxuser> net use \\10.10.10.178\Users /delete
