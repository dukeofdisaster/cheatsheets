# ssrf stuff
file:///localhost:1234/
http://localhost;1234
dict://localhost:1234/
http://0.0.0.0:1234/



## Need to resolve a domain to localhost or any ip? XIP.IO FOR THE WIN
xip.io will resolve any IP you give it as a subdomain, i.e. 127.0.0.1.xip.io

## methodology
1. If you find a very clear possible opening for SSRF, try modifying the url
ever so slightly to see how far you can get to get a sense of the filter.
- https -> http
- https://domiain.com/file.txt => https://domain.com./file.txt

2. Does the regex just make sure that the whitelist domain is in the url?
