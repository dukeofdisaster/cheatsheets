# Stuff I've ran into and wanted to note
- try NON standard verbs over http and see what happens example: pipe.ova
```
curl -vX BOB http://192.168.56.104/index.php
```

- Target is apache, can you read .htpasswd? /var/www/html/.htpasswd; if so, 
try cracking any found hashes

- The web app accepts common hash type of strings as cookies or other; the hash
you are injecting isn't working; are you sure it's the right hash value? Echoing
strings into md5sum will often include trailing newlines. Instead of:

```echo admin | md5sum ```

try 

```echo -ne admin | md5sum``` 

Remember that 1 byte makes a huge difference in the hash

- If a request spits back html that has hidden values for a user, if changing 
the Accept: header will make a difference
  - Example: Accept: text/html => Accept: application/json

