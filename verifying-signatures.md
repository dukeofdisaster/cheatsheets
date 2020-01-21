# Verifying Signatures in linux and windows
## LINUX GPG
wget https://palace.com/somefile-or-iso
- download the file to verify; disregard if you already have it

wget https://someplace/KEYS
- download the pub keys for whatever you're verifying

gpg --import KEYS
- imports the signing key so gpg can verify 

gpg --verify somefile.iso.sig somefile.iso

## WINDOWS GPG
Download gpg4win
- https://gpg4win.org/download.html
