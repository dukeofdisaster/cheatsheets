# ldap
Some ldap servers allow NULL binding; try deleting posted username/password parameters entirely

## some sample ldap auth examples
uid=alice,ou=people,dc=wonderland,dc=net
ldapAuth.dnResolution.searchFilter = (|(uid=%u)(mail=%u))
ldapAuth.dnResolution.searchFilter = (uid=%u)
ldapAuth.dnResolution.searchFilter = (|(uid=%u)(mail=%u)(employeeNumber=%u))

## failed login
2012-10-01 10:52:51,460 INFO – user.auth: username=tom authenticated=false message=Invalid username
2012-10-01 10:55:05,662 INFO – user.auth: username=alice DN=uid=alice,ou=people,dc=wonderland,dc=net authenticated=false message=Invalid password
