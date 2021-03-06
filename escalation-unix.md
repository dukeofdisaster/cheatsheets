# Privesc in unix
## OS, kernel version, service pack info
```
cat /etc/issue
cat /etc/*releaseAbout: Display version info
cat /proc/version
ls /boot | grep "vmlinuz"
lsb_release -a
uname -a
```


## find user info
```
id
whoami
last
```

## check installed stuff, perms, hidden files
```
ls -lah
ls -lah /usr/bin/
ls -lah /sbin
yum list installed
dpkg-query -l
rpm -qa
ls -lah /usr/share/applications | awk -F '.desktop '{print $1}'
```

## Manual escalation
```
sudo su
sudo -i
sudo /bin/bash
sudo su-
sudo ht
pkexec visudo
/etc/passwd
/etc/sudoers
find / \( -perm -2000 -o -perm -4000\) -exec ls -ld {} \; 2>/dev/null
find / -type d \( -perm -g+w -or -perm -o+w \) -exec ls -adl {} \;
```

## Evaluate running services
```
ps aux 
ps aux -u root
systemctl status someservicename
top
pstree
cat /etc/services
service --status-all
```

## Check for scheduled tasks/jobs
```
cat /etc/cron.d/*
cat /var/spool/cron/*About: Show cron tasks
Can also be (cat /var/spool/cron/crontabs/*)
crontab -l
cat /etc/crontab
cat /etc/cron.(time)
systemctl list-timers
```


## Most common sploits
```
Kernel 2.26.x: Udev 1.4.1: https://www.exploit-db.com/exploits/8478/
Kernel 2.26.22 - 3.9: Dirtycow: https://www.exploit-db.com/exploits/40839/
Kernel 3.13.0-32: Overlayfs: https://www.exploit-db.com/exploits/37292/
Samba 2.2.*: Remote buffer overflow: https://www.exploit-db.com/exploits/7/
Kernel 2.6.39-3.2.2 or Ubuntu 11.10: Mempodipper: https://www.exploit-db.com/exploits/35161/
Kernel 2.6.37 ubuntu 10.04: Full-nelson: https://www.exploit-db.com/exploits/15704/
Kernel under 2.6.32.2 Ubuntu 10.04: Half-nelson: https://www.exploit-db.com/exploits/17787/
FreeBSD 9.0/9.1: mmap/ptrace: https://www.exploit-db.com/exploits/26368/
Kernel 2.4.x/2.6.x: https://www.exploit-db.com/exploits/9545/ - compile as: gcc -Wall -o 9545 9545.c -Wl,--hash-style=both
Linuxprivchecker.py: http://www.securitysift.com/download/linuxprivchecker.py
LinEnum.sh: https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
```
