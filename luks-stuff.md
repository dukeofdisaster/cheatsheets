# LUKS STUFF
## manually mount a LUKS encrypted hard drive 
```
cryptsetup luksOpen /dev/sdc myencrypteddrive
mount /dev/mapper/myencrypteddrive /mnt
```


