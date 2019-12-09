# detecting xxe bugs in the wild; as may be relevant to play-framework
In the wild, you can't be sure that the server will be allowed to connect back
to you. To detect this bug (and if the server resolves external names), you can
use DNS.

To do so, you just need to setup a DNS server and monitor its logs. Then you can
send the initial request with a XML entity pointing to your domain:
http://rand0m123.blah.ptl.io/. If the server is vulnerable to XML entity attacks
(and can resolve external DNS name), you will see a DNS query from the
vulnerable server. 
