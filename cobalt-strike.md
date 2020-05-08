# Cobalt Strike Tips
Covers some basic cobalt strike usage until I learn more.

Note the best resource is cobalt strike's own pdf documentation

## Setup Teamserver
Teamserver is your c2 typically behind a redirector
./teamserver 102.0.0.100 somesupersecretpassword
- starts the teamserver with c2's external IP, using shared password somesupersecretpassword

## Start cobalt strike
You'll be asked  for information, enter
- IP of your c2
- some nickname
- somesupersecret password

## Attacks
Creating an attack will ask for a listener, you can add one
- this will typically be IP address of your redirector
- you'll need your redirector domain
