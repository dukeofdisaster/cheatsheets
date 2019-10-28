# PFSENSE HOMELAB CONFIG
For a more robust homelab you should configure it like a proper network
protected by a firewall. This is useful, practical experience that is
easier than it seems at first.  VIRTUALBOX


## Note about general setup
It's important that you do some of these steps in order specifically for vbox
1. Create a host only network vboxnet0 with ip address 172.16.1.2/24
2. When pfsense get's booted you'll have 3 interfaces
  - bridged : whatever ip your bare metal host gets assigned on dhcp
  - host-only : connected to vboxnet0: this will be 172.16.1.1, or LAN in pfsense
  - intnet1   : internal only; this will be 172.16.2.1 or OPT1 in pfsense
3. IPS Server introduces another set 
  - adapter 1: host only, will get 172.16.1.4 set statically in pfsense
  - Adapter 2: attached to intnet1, i.e same as the kali vm 172.16.2.0/24
  - Adapter 3: a NEW internal network

## VM CONFIG
Our firewall doesn't need a lot of resources, it just needs to
tell shit where to go. 

### Requirements
1. 1 x CPU
2. 512-1024 MB RAM
3. 3 x NICS
- Adapter 1 : bridged adapter: WAN interface
- Adapter 2 : Host Only Adapter : LAN interface; vboxnet0
- Adapter 3 :Internal adapter : LAN interface; name this internal network
intnet 2 in vm config
- NOTE: Set all of the above before first install and pfsense should autodetect wan/ilan interfaces.
- NOTE2: The naming of internal networks is important that way we can differentiate how
         subsequent vms connect to the network; thus these should both have separate names
4. 1 x pfsense iso from pfsense site
5. Disable unneeded virtual hardware: usb controllers, audio, floppy drive. 



### MAC Considerations
If you'll be doing malware analysis consider the MAC addresses of your NICS;
some malware is written to detect VNIC's, which could alter behavior and 
affect analysis


## First boot

1. Enter 1 to boot Multi user or let it autoboot
2. Accept the pfsense license
3. Select Install pfSense
4. Continue with default keymap
5. Selet Auto (UFS) Guided Disk Setup
- This will finish quickly then ask if you want a shell;
6. Select no
7. Select Reboot and power off the vm.
8. Remove the iso from the VM otherwise it'll boot into the installer
- After reboot, if we've done well it'll autodetect our WAN  and 1 LAN interface
- If you don't see em2 (or the 3rd interface) don't worry, it should come up later
after we configure em1 then go back to assign interfaces
9. Select option 2 to set interface IP's
10. Select option 2 (or whichever is relevant) to configure LAN; in my case, em1
12. Enter LAN ipv4 address
- 172.16.1.1
- This should be intnet1 (vboxnet0); compare the mac addresses
13. Enter a bit count
- 24 i.e (subnet mask of /24 i.e 255.255.255.0)
14. Leave the upstream gateway address blank
15. Enter y to enable DHCP server on LAN
16. Enter Start address of the dhcp range
- This can be somewhat arbitrary / dependant on what your lab will look like
- Sample ranges: 172.16.1.10 - 172.16.1.254, 172.16.1.100 - 172.16.1.200
- Some random internet article said default dhcp range for /24 is 100-149
- let's do that
17. Enter End address of the dhcp range
18. Enter n because we do not want to revert to HTTP as webConfigurator protocol
- I assume this is because it will try to use https and fail if no https or tro
to revert to http. And i'm assuming we don't want to allow plaintext protocols
anywhere as this leaves our data exposed in transit
19. This will put you back at the main menu; select 1 to assign interfaces;
20. Select N because we don't need vlans here.
21. Enter WAN interface name
- Recall your WAN (bridged) interface from earlier; in my case i know it's em0
so i can tell pfsense that
22. Enter lan interface name 
- (we just configured this, it's em1)
23. Enter the Optional 1 interface name
- we only have 1 left, which is em2
24. Enter y to proceed
- This will write the config and reload things; then we'll assign the
- ip address for OPT 1
25. Select 2
- We're going to complete the same process for OPT1 as we did for LAN
26. Select 3 for OPT1 (em2)
27. Enter OPT1 IP address
- 172.16.2.1
28. Enter new OPT1 IPv4 subnet bit count
- 24
29. Leave upstream gateway blank
30. Leave ipv6 address blank
31. Enter y to enable dhcp server
32. Enter Start address of dhcp range
- 172.16.2.100
33. Enter End address of dhcp range
- 172.16.2.149
34. Now that those interfaces have been configured, change the ip adress of the
host only interface on the HOST vm
  - linux: ifconfig vboxnet0 172.16.1.2 netmask 255.255.255.0
  - linux (shorter): ip addr add 172.16.1.2/24 dev vboxnet0

That should complete the setup of pfsense; to connect to the webconsole management interface,
we can stall another VM, and set this vm's network adapter intnet1 and we should be able to
hit the management interface on 172.16.1.1

## Managing pfsense from the gui

1. Choose management box ( i had win10deveval vm handy so used this)
2. CHANGE  THE DEFAULT PASSWORD : FIT
3. IN System -> General Setup Set some DNS servers; google and cloudflare
should be fine. 
4. Click Add DNS Server To add as many dns serves as you want
5. Navigate to Firewall -> Rules -> LAN ; note your default rules
6. Lock Down Access to the management interface to be only accessible from our win10 box
  - Action: Pass
  - Interface: LAN
  - Address fam: ipv4
  - Protocol: TCP
  -Source: Single host 172.16.1.100
  - Destination: single host: 172.16.1.1
  - Destination Port Range: 443-443
  - Description: pfsense strict anti-lockout
7. After this rule has been added, Disable webConfigurator antilockout route
  - System -> Advanced -> Admin access
  - Don't forget to save after every change
8. Disable the RFC1918 Networks rule on WAN interface
  - This is visible from the Firewall -> Rules section but gets disabled in
  interfaces -> WAN
9. Create Alias for RFC 1918 Networks
  - Firewall -> Aliases
  - Click add
  - Name: RFC1918
  - Type: Networks
  - Add these 3 networks and give them a description: 172.16.0.0/12 192.168.0.0/16 10.0.0.0/8
  - save and apply changes
10. Take a snapshot of pfsense VM

## More Rules to add LAN
The following rules are in order and what we'll want to allow. 

These are for LAN interface at 172.16.1.1

Note the order in which you add rules matters, if you put a block all rule at the top
and save changes, you'll lock yourself out

1. Our anti lockout rule allowing 1.100 is already defined; LET THIS STAY ON TOP
2. PASS, UDP, 172.16.1.0/24 ANY -> 172.16.1.1 53 (DNS) Gateway:any
3. PASS, UDP, 172.16.1.0/24 ANY -> 172.16.1.1 123 (NTP) Gateway:any 
4. PASS, TCP, 172.16.1.0/24 ANY -> 172.16.1.1 3128 (squid proxy) Gateway:any 
5. PASS, TCP, 172.16.1.100 ANY -> 172.16.2.101 22 (SSH) Gateway:any (allows ssh to kali vm)
  - this may not be exact; double check the ip of the kali vm
6. BLOCK, IPV4+6, tcp/udp, ANY  ANY -> RFC1918 ANY Gateway:any (deny access to any other rfc1918 network)
7. PASS, IPV4 TCP, 172.16.1.0/24 ANY -> ANY 443 Gateway:any (allow web traffic outbound)
8. BLOCK, ANY ANY ANY ANY 

These rules can be duplicated on the opt1 net; without http/https/dns pass
rules your kali vm won't be able to update.

## Test connection between win10 and kali vim
You won't be able to ping this as we haven't allowed it, but you 
should be able to ssh to the kali vm. You may have to edit the sshd config

1. Edit /etc/ssh/sshd_config
2. PasswordAuthincation yes
3. PermitRootLogin yes


## Set Static IP Addresses for current vms if you want.
To guarantee our IP addresses  don't change, we  can set static IP addresses in 
the pfsense gui. 

NOTE: Chances are your windows VM got an IP from DHCP; in which case, you can't set
the static IP to it's current DHCP IP address or any other IP address in the DHCP Range. 

Static IP shouldn't be needed here, but it would be a good exercise to set one.

1. Navigate to Services -> DHCP Server
2. Scroll all the way to the bottom of LAN
3. Locate teh bar titled: DHCP Static Mappings for this Interface
4. Click add
5. On your windows host, you can check mack via
  - cmd> getmac


## Backup PFSense config
Best practice dictates config backups. 

1. Navigate to Diagnostics -> Backup and Restore
2. Click Download Configuration as XML
  - Deviating from defaults shouldn't be necessary. 
3. Save this xml file in a special place

For easiest use I created a shared folder on the win10 box mapped to
/opt/vbox/shared where i could save various files


## Build a Siem Server : Splunk Edition
For this you'll need an Ubuntu 18.04 LTS server

1. Configure vm with 80GB Disk.
2. Give VM internal network adapter and note the mac
  - This will be used later in pfsense to force a static
    ip address
  - Make sure it's on intnet1 or 172.16.1.0/24 network
  - 0800278FFA80
3. Give the machine static ip in pfsense GUI.
4. Boot the box, and go through install; test connection to the web and ensure 
ip address has been set to the static IP that you have chosen.
5. Update the server
  - sudo apt update && apt-get dist-upgrade
  - reboot the server after all upgrades have been installed
6. Sign up for splunk free edition and download the splunk .deb file
  - I didn't send my siem box to the web, i downloaded it to shared folder
then scp'd it from management box -> siemserver
7. Install the .deb
  - dpkg -i splunk-8.deb
  - I renamed my deb file for ease.
  - OPTIONAL: if you know what you're doing, you may want to make a symlink to
the splunk binary in /usr/local/bin that way it's in your path
8. To start splunk, we have to accept the splunk license 
  - /opt/splunk/bin/splunk start --accept-license 
  - this will ask you for a splunk username (make it your user account name)
  - Also prompts for password; 
  - starts splunk at http://siemserver:8000/
9. Make splunk startup at boot
  - /opt/splunk/bin/splunk enable boot-start
10. IF needed, add a firewall rule to allow management box to hit siem
11. Make splunk use SSL
  - SSL all the things
  - Settings -> Server Settings -> General Settings -> Enable SSL
  - The splunk service will have to be restarted.

That about completes the splunk setup unless you want to look into the dev license.

## Build an IPS VM; suricata edition
For this we'll reuse the ubuntu server 18 LTS edition iso.
1. VM CONFIG
  - name: IPS
  - RAM: 2G
  - DISK: 80G, VDI
  - CPUS: 2
  - Disable audio
  - Disable USB controller
  - NETWORK SETTINGS (very important here)
    1. Adapter 1
      - Host-Only ethernet adpater
      - Document the mac
      - Mine: 080027af26b7
    2. Adapter 2
      - Attached to NOT ATTACHED
      - Document the mac of this interface
      - mine: 0800270f9a62
    3. Attached to Not attached
      - Document the mac
      - 080027af26b7
  - Install the server 
2. Adapter 1 should get a dhcp lease from pfsense during install..
3. After install turn off the vm; set static ip ov 172.16.1.4 for
adapter 1. 
4. If adapater 2 ( attached 172.16.2.0/24 network) didn't get a dhcp
lease, you can force it 
  - dhclient -v -4 enp0s8 ( or whatever the interface name is)
