# Bloodhound tips (kali relevant only for setup)
## Setup
$ apt-get install bloodhound
$ neo4j console 
- browse to: http://localhost:7474/browser/
- default crds: neo4j:neo4j, add new password
- should seee: connected as user neo4j to bolt://localhost:7687

$ bloodhound
- launches web console, login with neo4j creds from step above
- need data

## runing SharpHound on target
Need to get the data from target to blodhound running on localbox

```
PS> import-module .\SharpHound.ps1
PS> invoke-bloodhound -jsonfolder "C:\some\writeable\folder" -collectionmethod All
```

## can't execute shit on target... so what?
Need to run remotely, but you'll have to make sure to point it at the domain's dns server (look for port 53 open on box)

```
pip install bloodhound
bloodhound-python -ns 10.10.10.161 -u svc-user -p password1 -d somedomain.local -c All
```


this will dump a bunch of json files you can then load into the bloodhound ingestor.

## Some cases
- got a svc user, see shortest paths to high value targets
