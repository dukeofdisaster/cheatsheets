# cracking command lines
**TODO:** Expand
## THINGS TO REMEMBER
  - a 0 == dictionary mode

## cisco / md5crypt hash cracking
- ex:  $1$28772684$iEwNOgGugqO9.bIz5sk8k/ 
```
hashcat -m 500 -a 0 -o cracked.txt hash.txst /usr/share/wordlists/rockyou.txt
```
