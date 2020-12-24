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
vboxmanage list runningvms
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
```
vboxmanage snapshot VMNAME restore "snapshot-name-here"
```


## import ova 
used this for importing the win10 dev vms; didn't want to manage/run them on
my local box, wanted headless and then setup beats for playing with logs
```
vboxmanage import --dry-run

root@metalbox:~# vboxmanage import WinDev2009Eval.ova --dry-run
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting /root/WinDev2009Eval.ova...
OK.
Disks:
  vmdisk1	136365211648	-1	http://www.vmware.com/interfaces/specifications/vmdk.html#streamOptimized	WinDev2009Eval-disk001.vmdk	-1	-1

Virtual system 0:
 0: Suggested OS type: "Windows10_64"
    (change with "--vsys 0 --ostype <type>"; use "list ostypes" to list all possible values)
 1: Suggested VM name "WinDev2009Eval"
    (change with "--vsys 0 --vmname <name>")
 2: Suggested VM group "/"
    (change with "--vsys 0 --group <group>")
 3: Suggested VM settings file name "/root/VirtualBox VMs/WinDev2009Eval/WinDev2009Eval.vbox"
    (change with "--vsys 0 --settingsfile <filename>")
 4: Suggested VM base folder "/root/VirtualBox VMs"
    (change with "--vsys 0 --basefolder <path>")
 5: Number of CPUs: 1
    (change with "--vsys 0 --cpus <n>")
 6: Guest memory: 2048 MB
    (change with "--vsys 0 --memory <MB>")
 7: Sound card (appliance expects "", can change on import)
    (disable with "--vsys 0 --unit 7 --ignore")
 8: USB controller
    (disable with "--vsys 0 --unit 8 --ignore")
 9: Network adapter: orig NAT, config 3, extra slot=0;type=NAT
10: CD-ROM
    (disable with "--vsys 0 --unit 10 --ignore")
11: SATA controller, type AHCI
    (disable with "--vsys 0 --unit 11 --ignore")
12: Hard disk image: source image=WinDev2009Eval-disk001.vmdk, target path=WinDev2009Eval-disk001.vmdk, controller=11;channel=0
    (change target path with "--vsys 0 --unit 12 --disk path";
    disable with "--vsys 0 --unit 12 --ignore")
```
- just remove the dry run to execute

## headless modify bridge
https://devminz.github.io/posts/devops/virtualbox-cli-vm-bridged-networking/

- create the bridge
- this ended up working; somehow the VM got the correct IP address


## find out VM ip address
This requires installation of guest additions ISO
```
vboxmanage guestproperty WinDev2009Eval | grep IP
```
vboxmanage 
# LINKS / REFERENCES
1. https://www.virtualbox.org/manual/ch06.html covers vbox networking in depth; includes examples.

### commands
 1092  vboxmanage import WinDev2009Eval.ova --dry-run
 1093  vboxmanage import WinDev2009Eval.ova 
 1097  vboxmanage list
 1098  vboxmanage list vms
 1099  vboxmanage start --headless Windows10_64
 1102  cat vboxmanage.md 
 1103  vboxmanage startvm Windows10_64 --type headless
 1108  vboxmanage startvm Windows10_64 --type headless
 1110  vboxmanage startvm Windows10_64 --type headless
 1111  vboxmanage list vms
 1112  vboxmanage startvm WinDev2009Eval --type headless
 1119  vboxmanage stopvm WinDev2009Eval
 1120  vboxmanage stopWinDev2009Eval
 1121  vboxmanage 
 1122  vboxmanage  | grep stop
 1124  vim vboxmanage.md 
 1125  grep power vboxmanage.md
 1126  vboxmanage controlvm WinDev2009Eval poweroff
 1128  vim vboxmanage.md 
 1130  vboxmanage showvminfo WinDev2009Eval
 1140  vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype1 82545EM --bridgeadapter1 vboxbr1
 1142  vboxmanage modify WinDev2009Eval --vrde on
 1143  vboxmanage modifyvm WinDev2009Eval --vrde on
 1146  vboxmanage startvm WinDev2009Eval --type=headless
 1147  vboxmanage list vms
 1153  vboxmanage showvminfo 192.168.2.29
 1154  vboxmanage showvminfo WinDev2009Eval
 1158  vboxmanage showvm
 1161  history | grep vboxmanage >> vboxmanage.md 

showvminfo will give you the nic information but we can't see an IP that got
assigned
