# VIRTUALBOX MANAGEMENT CHEAT SHEET
This cheat sheet covers some useful virtualbox commands for administrating
virtualbox from cli

## see all vms
```
root@box~/# vbox manage list vms
"vm" {3181befb-fe61-4a2c-984e-a3954c5d031e}
"HF2019-Linux" {4762357c-6c54-42be-91ad-d5088ff23e3e}
"Lab26" {54b9d8ed-f826-41cd-abfb-b3003a18437c}
```

## see running vms
```
vboxmanage list runningms
```

## start a vm headless
```
vboxmanage startvm "vmname" --type headless
```

##  Power off a vm (quotes optional)
vboxmanage convrolvm "vmname" poweroff

## list all snapshots of a vm
```
vboxmanage snapshot VMNAME list
```

## Restore a vm (doesn't start it ); after restore, start vm
vboxmanage snapshot VMNAME restore "snapshot-name-here"

# LINKS / REFERENCES
1. https://www.virtualbox.org/manual/ch06.html covers vbox networking in depth; includes examples.
