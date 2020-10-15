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
```
vboxmanage snapshot VMNAME restore "snapshot-name-here"
```

## setup manual bridge for linux host + bridged guest
Used this on WinDev2009Eval ova successfully; 

```
brctl addbr vboxbr1
    - add a bridge interface named vboxbr1
ip a
    - confirm it was created
ifconfig vboxbr1 192.168.222.1 netmask 255.255.255.0 up
    - configure the bridge with the above ip address and netmask
    - alternatively: ip addr add 192.168.221.1/24 dev vboxbr1
    - I believe the chosen ip addr is arbitrary, shoulc have been 111.1
vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype1 82545EM --bridgeadapter1 vboxbr1
    - note that we have to append each arg with "1", i.e. the first nic
```

# LINKS / REFERENCES
1. https://www.virtualbox.org/manual/ch06.html covers vbox networking in depth; includes examples.

# Appendix - history dump
```
 1052  vim vboxmanage.md 
 1094  vim vboxmanage.md 
 1239  vboxmanage import WinDev2009Eval.ova --dry-run
 1240  vboxmanage import WinDev2009Eval.ova 
 1244  vboxmanage list
 1245  vboxmanage list vms
 1246  vboxmanage start --headless Windows10_64
 1249  cat vboxmanage.md 
 1250  vboxmanage startvm Windows10_64 --type headless
 1255  vboxmanage startvm Windows10_64 --type headless
 1257  vboxmanage startvm Windows10_64 --type headless
 1258  vboxmanage list vms
 1259  vboxmanage startvm WinDev2009Eval --type headless
 1266  vboxmanage stopvm WinDev2009Eval
 1267  vboxmanage stopWinDev2009Eval
 1268  vboxmanage 
 1269  vboxmanage  | grep stop
 1271  vim vboxmanage.md 
 1272  grep power vboxmanage.md
 1273  vboxmanage controlvm WinDev2009Eval poweroff
 1275  vim vboxmanage.md 
 1277  vboxmanage showvminfo WinDev2009Eval
 1280  brctl addbr vboxbr1
 1282  ifconfig vboxbr1 192.168.222.1 netmask 255.255.255.0 up
 1286  vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype 82545EM --bridgeadapter1 vboxbr1
 1287  vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype1 82545EM --bridgeadapter1 vboxbr1
 1289  vboxmanage modify WinDev2009Eval --vrde on
 1290  vboxmanage modifyvm WinDev2009Eval --vrde on
 1291  vboxmanage startvm WinDev2009Eval --headless
 1292  vboxmanage startvm WinDev2009Eval type=--headless
 1293  vboxmanage startvm WinDev2009Eval --type=headless
 1294  vboxmanage list vms
 1300  vboxmanage showvminfo 192.168.2.29
 1301  vboxmanage showvminfo WinDev2009Eval
 1305  vboxmanage showvm
 1308  history | grep vboxmanage >> vboxmanage.md 
 1309  vim vboxmanage.md 
 1310  grep poweroff vboxmanage.md 
 1311  vboxmanage controlvm WinDev2009Eval poweroff
 1312  cat vboxmanage.md 
 1314  vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype1 8245EM --bridgeadapter1 enp0s25
 1315  vboxmanage modifyvm WinDev2009Eval --nic1 bridged --nictype1 82545EM --bridgeadapter1 enp0s25
 1316  vboxmanage startvm WinDev2009Eval
 1320  vim vboxmanage.md 
 1322  vim vboxmanage.md 
 1325  vboxmanage list vms
 1326  vboxmanage show runningvms
 1327  grep running vboxmanage.md 
 1328  vboxmanage list runningvms
 1329  vim vboxmanage.md 
 1330  vboxmanage modifyvm WinDev2009Eval --nicpromisc1 allow-all
 1331  vboxmanage controlvm WinDev2009Eval poweroff
 1332  vboxmanage modifyvm WinDev2009Eval --nicpromisc1 allow-all
 1333  vboxmanage startvm  WinDev2009Eval
 1334  vboxmanage guestproperty enumerate WinDev2009Eval
 1335  vboxmanage startvm  WinDev2009Eval
 1336  vboxmanage startvm  WinDev2009Eval --type=headless
 1337  vboxmanage guestproperty enumerate WinDev2009Eval
 1338  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1339  vboxmanage guestproperty enumerate WinDev2009Eval
 1340  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1354  vboxmanage controlvm WinDev2009Eval poweroff
 1355  vboxmanage modifyvm WinDev2009Eval --vrde on
 1356  vboxheadless --startvm WinDev2009Eval --vrde on
 1357  vboxmanage list runningvms
 1358  vboxmanage startvm WinDev2009Eval --type=headless --vrde on
 1359  vboxmanage startvm WinDev2009Eval --type=headless --vrde=on
 1360  vboxmanage startvm WinDev2009Eval --type=headless
 1361  vboxmanage guestpropety enumerate WinDev2009Eval
 1362  vboxmanage guestproperty enumerate WinDev2009Eval
 1363  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1364  vboxmanage guestproperty enumerate WinDev2009Eval | grep vrde
 1365  vboxmanage guestproperty enumerate WinDev2009Eval | grep remote
 1366  vboxmanage guestproperty enumerate WinDev2009Eval | grep -i remote
 1372  vboxmanage list runningvms
 1373  vboxmanage list vms
 1374  vboxmanage startvm WinDev2009Eval --type=headless --vrde=on
 1375  vboxmanage startvm WinDev2009Eval --type=headless --vrde
 1376  vboxmanage startvm WinDev2009Eval --type=headless
 1377  vboxmanage guestproperty enumerate WinDev2009Eval
 1378  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1379  vboxmanage startvm WinDev2009Eval --type=headless
 1380  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1382  vboxmanage guestproperty enumerate WinDev2009Eval | grep IP
 1383  vboxmanage guestproperty enumerate WinDev2009Eval
 1384  vboxmanage controlvm WinDev2009Eval poweroff
```
