# 7zip tips
archive everything in a dir and subdirs
- Use Case: Say you're in /var/www/html/ and you want to backup a site
```
7za a -tzip backup.zip .
```

Extract said backup
```
7za x backup.zip
```
