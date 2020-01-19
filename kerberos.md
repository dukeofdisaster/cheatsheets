# kerberoasting  stuff
[tarlogic - good examples](https://www.tarlogic.com/en/blog/how-to-attack-kerberos/)

## impacket
./GetNPUsers.py htb.local/ -usersfile /home/boxuser/gitstuff/hax/windows/forest-10.161/users.txt  -format hashcat -outputfile hashes.asreproast
  - harvests Non-Preauth AS_REP responses  given a users list
  - use case: find an ldap server that allows us to null bind and query objects on a windows server, from there
    we get userslist, and we can supply this
   - Recommendation: try digging through a full dump for svc accounts, depending on the way user accounts are
     organized, svc accounts may not always end up in a dump list when using some of the canned queries you
     find online.
