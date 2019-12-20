# RSA KEYS
Despite it's appearance, a given RSA key, whether public / private is more than
just it's a long string of seemingly random data. The key actually has several
objects needed for encryption/decryption etc. You might recognize some of the
variable names if you've ever read up on the algorithm itself.

https://simple.wikipedia.org/wiki/RSA_algorithm

In total, there are at least 6 values which we can extract from a key using
python
- ['n', 'e', 'd', 'p', 'q', 'u']

We only need to extract n and e from OUR priv key and replace these in to our
malicious cookie after we sign our malicious payload. WHY? Because n+e together
constitutes the publlic key; i.e. the token uses attacker-supplied public keys
to verify attacker supplied data; if you control the verification method or
means, you control the data. 

## extracting n and e from priv
in python we can do this very easily

- python3  -c 'from Crypto.PublicKey import RSA; f = open("my.priv","r"); key = RSA.importKey(f.read()); print(key.n); print(key.e);'
