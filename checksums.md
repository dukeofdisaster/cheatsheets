# Checksums
checksumm = df. noun - a digit representing the sum of the correct digits in a 
piece of stored or transmitted digital data, against which later comparisons
can be made.

The following are common method sof getting checksums on different Operating Systems

## Mac / Unix
- shasum: this is a perl script found on both mac and redhat/ubuntu

```
shasum -a 1 file.txt
root@box:# shasum -a 1 restuff.txt
80e140b4565baa13bea5b1a5e4b9bf31724581fc  restuff.txt
shasum -a 224 file.txt
shasum -a 256 file.txt
shasum -a 512 file.txt
```

- openssl: the bottomless utility openssl

```
openssl md5 file.txt
openssl sha1 file.txt
openssl sha224 file.txt
openssl sha256 file.txt
openssl sha384 file.txt
openssl sha512 file.txt
root@box# openssl sha384 restuff.txt
SHA384(restuff.txt)= 3bb913320d340d0fee067d413b1be45c3e5e84d42196ebcbc7eba822993f6d74d0fb6f7daf0d6dbf9ff58c051e7cbbcc

openssl help
--- SNIP
blake2b512        blake2s256        gost              md4
md5               rmd160            sha1              sha224
sha256            sha3-224          sha3-256          sha3-384
sha3-512          sha384            sha512            sha512-224
sha512-256        shake128          shake256          sm3
--- /SNIP
```

- md5sum: common md5 utility found on linux
```
md5sum file.txt
``

## Windows
certutil: windows built in utility can be used for getting hashes
```
certutil -hashfile .\myfile.txt MD5
certutil -hashfile .\myfile.txt SHA1
certutil -hashfile .\myfile.txt SHA224
certutil -hashfile .\myfile.txt SHA256
```

get-filehash: i think this is essentially an alias over certutil
```
get-filehash c:\users\badfile.txt
    - defaults to SHA256
get-filehash c:\users\badfile.txt -Algorithm SHA1
get-filehash c:\users\badfile.txt -Algorithm SHA512
get-filehash c:\users\badfile.txt -Algorithm MD5
```
