# postgess stuff

connect to db if there are default users
```
psql some.db
```

List dbs
```
\list
```

Connect to db 
```
\c db name
```

Dump tables from connected database
```
\dt
```

Dump text 
```
CREATE TABLE faketable(t text);
COPY faketable from '/some/file/here.txt';
SELECT * FROM faketable;
DROP TABLE fakteable;
```
