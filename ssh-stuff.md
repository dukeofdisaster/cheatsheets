# SSH TIPS
default priv key privs: 600, rw-------

## generate a lost pub key from priv key
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

## test github ssh access after copying .pub key into github settings
ssh -T git@github.com
git remote set-url origin git@github.com:dukeofdisaster/cheatsheets.git
- will allow us to push to remote
- [read more](https://gist.github.com/developius/c81f021eb5c5916013dc)

## SSH tunnels - reverse proxy
1. First we need to create a socks listner on server1
```bash
user@server1~$ ssh -f -N -D 54321 localhost
```
- -f : will send this operation to the background after completion
- -N : No execution of commands 
- -D : creates local Dynamic application level port forwarding; basically makes
ssh become a SOCKS server on that port
- NOTE: Alternatively add -C flag to compress traffic and save bandwidth
- You should be able to see the listening port with netstat
```
user@some-server1:~$ netstat -antp | grep 54321
tcp        0      0 127.0.0.1:54321             0.0.0.0:*                   LISTEN      20809/ssh
```
2. Next we need to to use ssh to forward a remote port toe thocal bind port
that we just created
```
some_user@some-server1$ ssh some_user@some-server2 -R6666:localhost:54321
```
- -R : binds remote port 6666 on some-server2 to localhost:54321 (localhost in this case would be
some-server1:54321 since this is where the command is being ran from)

3. Now on remote host, youll have to configure connections to proxy out the socks connection
```
user@some-server2~/$ export $all_proxy=socks://localhost:6666
```
- a majority of common linux utilities will honor this environment variable

4. Alternatively, just use command line flags
```
some-server2$ curl --socks5 localhost:6666 www.google.com
```

This is great, but still can't get out with pip3 :( WOMP WOMP WOMP
- solution: install pysocks from host's package manager, then socks proxy out over the tunnel
```
some-server2 yum -y install python36-pysocks
some-server2$ sudo pip3 --proxy socks5:127.0.0.1:6666 install libtaxii
```
