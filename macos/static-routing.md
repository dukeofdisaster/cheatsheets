# macOS Static Routing.
Sometimes you need to add a static route on a mac. 

- scenario: i have a homelab network on 192.168.2.0/24 and main home LAN is 
on 192.168.0.0/24; my main router does not issue routes for the homelab; I can
ping from LAB => LAN but not the other way around. I need a route to man LAB
network. These networks are connected via a bridge running on an RPI; rpi
gets main internet via lan on wlan0 192.168.0.231, and the bridge device ip (irrelevant here) is 192.168.2.2; we just have to be aware of the next hop which is 0.231
```
sudo route -n add -net 192.168.2.0/24 192.168.0.231
```
    - i.e. If i'm a client on 192.168.0.0/24 and I need to get to
    192.168.2.0/24, i can get there via 192.168.0.231
