#!/bin/bash
#
#
# USE: Grep through source code in an attempt to identify dynamically built queries
#
#

# grep for queries
grep -EnH --color '\$q=|\$query=|\$qry=|\$q =|\$query =|\$qry =|\$SQL=|\$SQL =|\$sql=|\$sql =' $1

# Grep for PHP string concatenation
grep -EnH --color '\"\+\"' $1
grep -EnH --color '\" \. \"|\". \"|\"\. \$|\" \. \$' $1
grep -EnH --color "\' \. \'|\'. \'|\'\. \$|\' \. \$" $1


# Grep for logical operators in sql stements
grep -EnH 'SELECT|FROM|WHERE|ORDERBY|JOIN|UNION' $1 | grep -EnH --color "< \'\$|> \'\$ |\+ '\$"
