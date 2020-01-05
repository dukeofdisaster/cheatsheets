# Making bootable usb with persistence
## Assumptions
Drive size: 128G
Drive at: /dev/sdb
Persistence size: 120Gb; slightly less than what's free after imaging

## Image drive

```bash
dd if=kali-linux-****.iso of=/dev/sdb bs=1M
```

## Create the partition

When prompted type Yes and Ignore; it's inconsequential

```
end=120gb
root@box:~/Downloads# read start _ < <(du -bcm kali-linux-2019.4-amd64.iso | tail -1); echo $start
2636
root@box:~/Downloads# parted /dev/sdb mkpart primary $start $end
Warning: You requested a partition from 2636MB to 120GB (sectors 5148437..234375000).
The closest location we can manage is 2764MB to 120GB (sectors 5397632..234375000).
Is this still acceptable to you?
Yes/No? Yes
Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? Ignore
Information: You may need to update /etc/fstab.
```

## Create file system on the partition

Will take a little while labels the partition "persistence"

```bash
root@box:~/Downloads# mkfs.ext3 -L persistence /dev/sdb3
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 28622171 4k blocks and 7159808 inodes
Filesystem UUID: fa097840-1c55-40f6-98a8-32b2b488150f
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
	4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (131072 blocks): done
Writing superblocks and filesystem accounting information: done

root@box:~/Downloads# e2label /dev/sdb3 persistence
root@box:~/Downloads# mkdir -p /mnt/mybootable
root@box:~/Downloads# mount /dev/sdb3 /mnt/mybootable
root@box:~/Downloads# echo "/ union" > /mnt/mybootable/persistence.conf
root@box:~/Downloads# umount /dev/sdb3
```
The last 4 commands make a directory to mount the newly created partition,
then we create the conf that will enable the persistence on boot of the usb
