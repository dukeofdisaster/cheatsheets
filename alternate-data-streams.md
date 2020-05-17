# alternate datastream stuff
## check for stream
```
PS C:\Users\boxuser> Get-Item -path '\\10.10.10.178\Users\someuser\somedir\SomeFilename.txt' -stream *


PSPath        :Microsoft.PowerShell.Core\FileSystem::\\10.10.10.178\Users\someuser\somedir\SomeFilename.txt::$DATA
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::\\10.10.10.178\Users\someuser\somedir
PSChildName   : SomeFilename.txt::$DATA
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : \\10.10.10.178\Users\someuser\somedir\SomeFilename.txt
Stream        : :$DATA
Length        : 0

PSPath        : Microsoft.PowerShell.Core\FileSystem::\\10.10.10.178\Users\someuser\somedir\Debug Mode
                Password.txt:Password
PSParentPath  : Microsoft.PowerShell.Core\FileSystem::\\10.10.10.178\Users\someuser\somedir
PSChildName   : SomeFilename.txt:Password
PSProvider    : Microsoft.PowerShell.Core\FileSystem
PSIsContainer : False
FileName      : \\10.10.10.178\Users\someuser\somedir\Debug Mode .txt
Stream        : Password
Length        : 15
```

## Get The Stream
PS C:\Users\boxuser> Get-Content -path '\\10.10.10.178\Users\SomeUser\SomeFIle.txt' -stream Password
Sup3rS3cr3tOutputHere
