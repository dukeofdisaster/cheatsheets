# BASIC SQLITE COMMANDS
- connect to db
```
user@box:/$ sqlite3 database.db 
SQLite version 3.8.7.1 2014-10-29 13:59:56
Enter ".help" for usage hints.
```

- Show tables
```
sqlite> .tables
users
```

- Select users
```
sqlite> select * from users;
admin|somehashere
```
