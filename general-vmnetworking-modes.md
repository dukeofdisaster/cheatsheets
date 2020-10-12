# The following table generally applies to vmnetworking

```ascii
| MODE    | VM -> HOST | VM <- HOST | VM1 <-> VM2 | VM -> NET/LAN | VM <- NET/LAN |
-----------------------------------------------------------------------------------
|Host Only|    YES     |     YES    |       YES   |      NO       |         NO    |
-----------------------------------------------------------------------------------
|Internal |   NO       |      NO    |       YES   |      NO       |       NO      |
-----------------------------------------------------------------------------------
Bridged   |   YES      |      YES   |     YES     |     YES       |      YES      |
-----------------------------------------------------------------------------------
```

| MODE | VM->host | VM <- HOST | VM1<->VM2 | VM -> NET/LAN | VM <- NET/LAN |
|---|---|---|---|---|---|
| Host Only  | YES | YES | YES | NO | NO |
| Internal  | NO | NO  | YES  | NO | NO |
| Bridged | YES  | YES  | YES | YES | YES |
