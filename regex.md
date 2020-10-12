# Regex stuff
## vim; delete all linens that start with quotes and any series of numbers;
- used for deleting auto-named doc id's for saved searches in kibana
```
:%g/^\"[0-9].*$/d
```

## grep; extract suricata rule sid from a line; 
```
user@box:~$ cat rules.txt | grep -oe "sid:[0-9]\+"
sid:2800000
sid:2801946
sid:2805913
```

## vim; delete blank lines
```
:g/^$/d
```

## vim: replace empty quotes space between iocs with new line
```
:%s/\" \"/\r/g
```
## removed 0.0.0.0 ip's from a list of malicious ip's;
- sed is saying: take any line that starts with ```0``` followed by any ```.*``` chars and delete ```/<rules here>/d```
```
user@box:~$ cat badlist.txt | sed "/^0.*/d"
```
