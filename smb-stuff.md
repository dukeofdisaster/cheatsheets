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

