# OPENSSL CHEATSHEET
## Generate a newn private key and Certificate Signing Request
```
openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout privateKey.key
```

## Generate self-signed cert
```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt
```

## Generate a Certificate Signing Request for an existing private key
```
openssl req -out CSR.csr -key privateKey.key -new
```

## Generate a certificate signing request based on an existing certificate
```
openssl x509 -x509toreq -in certificate.crt -out CSR.csr -signkey privateKey.key
```

## remove a passphrase from a private key; assuming you know passphrase
```
openssl rsa -in privateKey.pem -out newPrivateKey.pem
```

## generate an rsa key for signing a token
```
openssl genrsa -out my.priv
==========================
Generating RSA private key, 2048 bit long modulus (2 primes)
............+++++
....+++++
e is 65537 (0x010001)
=====================
```
- in jwt, this is the e refereneced

## sign the token
```
echo 'someb64header.someb64payload' | openssl dgst -sha256 -sign my.priv -binary | openssl base64 | tr -- '+/=' '-_ '
```
