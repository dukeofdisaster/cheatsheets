# bash oneliners
## recursively download a directory with wget
```bash
wget --no-parent -r http://www.someplace.com/somedir/
```

## ping sweep 
```bash
for i in {1..254}; do ping -c 1 10.10.10.$i | grep 'from'; done
```

## same, saved to file
```bash
for i in {1..254}; do ping -c 1 10.10.10.$i | grep 'from'; done > hosts.txt
```

## same only ip's printed
```bash
for i in {1..254}; do ping -c 1 10.10.10.$i | grep 'from' | awk -F " " '{print $4}'; done
```

## parallel port scan with parallel, timeout, and nc
```bash
parallel "timeout 0.2 nc -z -v 192.168.0.105 {} 2>&1 | grep succeed" ::: {1..65535}
```

## same with ncat (for ipv6 support); note the output is different so grep changes
```bash
parallel "timeout 0.2 ncat -z -v dead:beef::250:56ff:fea2:1a06 {} 2>&1 | grep connected" ::: {1..65535}
```

## grep out hosts from same file; example
```bash
mark@NIX01:/tmp$ cat hosts.txt | awk -F " " '{print $4}'
172.16.1.5:
172.16.1.15:
172.16.1.22:
172.16.1.23:
172.16.1.24:
172.16.1.26:
172.16.1.30:
172.16.1.36:
172.16.1.101:

mark@NIX01:/tmp$ cat hosts.txt | awk -F " " '{print $4}' | tr -d ':'
172.16.1.5
172.16.1.15
172.16.1.22
172.16.1.23
172.16.1.24
172.16.1.26
172.16.1.30
172.16.1.36
172.16.1.101


## locate nmap scripts and only print out their names
```bash
user@user:~/ locate smb-enum | awk -F "/" '{print $5}'
```

## curl with spoofed user agent 
```bash
curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
```

## get a list of all unix commands available on your system... may vary
```
ls -l /usr/bin/ | awk -F " " '{print $9}'
```

## bash net redirection
- the below command will act essentially as a curl
exec 3<> /dev/tcp/www.google.com/80
echo -e "GET /" >&3
cat <&3

## simple bash port scan ; echo the open port to th screen
- note this isn't infallible; this fails on an open ssh port for some reason
for i in {1..65535}; do (echo "" > /dev/tcp/192.168.0.5/$i && echo $i)  2>/dev/null; done

## Generate a bunch of random files with
```bash
for n in {1..100}; do dd if=/dev/urandom of=file$(printf %03d "$n").bin bs=1 count=$$(1024*1000)) ; done
```

## Get status of file mod by size
TL;DR you executed an op on a large file (20G) and can't tell status, BUT
you do know the target size is about 20G, so you can do byte math to
figure out about how much it's done; 1=100%
```
du -b WinDev2009Eval.ova | awk -F " " '{print $1}' | while read i ; do echo $(($i / 1000000000)) | ruby -e 'puts ARGF.read.to_i / 20.0'; done
```
- note it's not 100 percent accurate either
