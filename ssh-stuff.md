# ssh tips
default priv key privs: 600, rw-------

## generate a lost pub key from priv key
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

## test github ssh access after copying .pub key into github settings
ssh -T git@github.com
git remote set-url origin git@github.com:dukeofdisaster/cheatsheets.git
- will allow us to push to remote
- [read more](https://gist.github.com/developius/c81f021eb5c5916013dc)

## SSH tunnels - reverse prox
ssh -f -N -D 54321 localhost
	- daemonizes a listener in the background that's running on port 54321, looking for ssh connections

some_user@some-server1:~$ netstat -antp | grep 54321
tcp        0      0 127.0.0.1:54321             0.0.0.0:*                   LISTEN      20809/ssh

some_user@some-server1$ ssh some_user@some-server2 -R6666:localhost:54321
	- binds remote port 6666 to localhost:54321 (localhost in this case would be
	  some-server1:54321 since this is where the command is being ran from
	- now on remote host, you just have to curl to localhost for whatever you need to d


some-server2$ curl --socks5 localhost:6666 www.google.com
	- since by ssh'ing from one host into the target(blocked server)) annd binding 6666 to
	  the connnection on 54321, we have a tunnel.


This is great, but still can't get out with pip3 :( WOMP WOMP WOMP
	- solution: install pysocks from host's package manager, then socks proxy out over the tunnel

some-server2 yum -y install python36-pysocks
some-server2$ sudo pip3 --proxy socks5:127.0.0.1:6666 install libtaxii
	- now we can get out via socks5  and ssh tunneling
