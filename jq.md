# JQ TIpS
jq is an extremely helpful tool for manipulatingn json but it can be a bitch to learn.

## grab only the value of field '\_id' from a narray of json object
- pipes the json objects to jq, then you select the array of objects '.[]'
and the field '\_id' for those objects; dumps a list of the id object
```bash
user@box:~$ cat savedsearches.json | jq '.[]._id'
```

## cybereason; taking query results and filtering down to individual results
```bash
cat som_results.json | jq '.data.resultIdToElementDataMap[] | .guidString'
```


## select an outer key with the given value
```bash
[root@box ~]# cat /opt/intel/badips.json | jq '.["68.183.156.156"]'
1569377667

# object of badips.json has the following structure
{
  "68.183.156.156": 1569377667,
  "69.10.54.134": 1569377667,
  "86.247.170.128": 1569377667,
  "91.236.116.89": 1569377667,
  "92.222.69.186": 1569377667,
  "51.254.199.97": 1569456757,
  "51.38.124.174": 1569456757,
  "51.75.202.12": 1569456757
}
```

## Flatten a json object in jq.
Can be thrown all on one line
```
. as $in
| reduce leaf_paths as $path ({};
     . + { ($path | map(tostring) | join(".")): $in | getpath($path) })
```
### also since it's jq we can pipe to it...
Normal structure below
=========================
```json
{
  "timestamp": "2019-09-26T23:42:44.407046+0000",
  "flow_id": 583945044637190,
  "in_iface": "eth0",
  "event_type": "alert",
  "src_ip": "109.248.11.201",
  "src_port": 43087,
  "dest_ip": "0.0.0.0",
  "dest_port": 123,
  "proto": "UDP",
  "alert": {
    "action": "allowed",
    "gid": 1,
    "signature_id": 2017919,
    "rev": 2,
    "signature": "ET DOS Possible NTP DDoS Inbound Frequent Un-Authed MON_LIST Requests IMPL 0x03",
    "category": "Attempted Denial of Service",
    "severity": 2,
    "metadata": {
      "updated_at": [
        "2014_01_02"
      ],
      "created_at": [
        "2014_01_02"
      ]
    }
  },
  "app_proto": "failed",
  "flow": {
    "pkts_toserver": 2,
    "pkts_toclient": 1,
    "bytes_toserver": 120,
    "bytes_toclient": 79,
    "start": "2019-09-26T23:42:44.407046+0000"
  }
}
```
- Command
```bash
[root@centos-digibox ~]# cat /var/log/suricata/eve-alert.json | jq '. as $in | reduce leaf_paths as $path ({}; . + { ( $path | map(tostring) | join(".")): $in | getpath($path) })'
{
  "timestamp": "2019-09-26T01:29:46.888694+0000",
  "flow_id": 228071697977206,
  "in_iface": "eth0",
  "event_type": "alert",
  "src_ip": "46.99.100.100",
  "src_port": 22,
  "dest_ip": "0.0.0.0",
  "dest_port": 59970,
  "proto": "TCP",
  "alert.action": "allowed",
  "alert.gid": 1,
  "alert.signature_id": 2210059,
  "alert.rev": 1,
  "alert.signature": "SURICATA STREAM pkt seen on wrong thread",
  "alert.category": "",
  "alert.severity": 3,
  "flow.pkts_toserver": 2,
  "flow.pkts_toclient": 0,
  "flow.bytes_toserver": 252,
  "flow.bytes_toclient": 0,
  "flow.start": "2019-09-26T01:29:46.888694+0000"
}
```

## selecting multiple fields from an array of json
- note: this will only display the values, not the keys
```bash
cat my-json-linefile.txt | jq '.somefieldhere,someotherfieldhere,field3,field4'
```

## pulling indicators out of OTX responses; works on multi-line json
```bash
rooto@box:~/ cat 10-feeds.json | jq -r '.results[] | .indicators[] | .indicator'
```

## extracting industries
```
cat 5day.json | jq .results[] | jq .industries
```

## Edit values in an existing file
- Note this will require some copying because the file isn't modifed, the
modified json is just sent to stdout
- Example for use in edit cloud-init (whole string passed to sh -c)
```
'jq ".admin_server.listen_url=\"0.0.0.0:3333\"" /opt/some/config.json |  tee /opt/some/tmp.json'
rm /opt/some/config.json && mv /opt/some/tmp.json /opt/some/config.json
```
- Example for multiple files
```
'jq ".admin_server.listen_url=\"0.0.0.0:3333\" | .admin_server.cert=\"/opt/something/dude.crt\"" /opt/some/config.json |  tee /opt/some/tmp.json'
rm /opt/some/config.json && mv /opt/some/tmp.json /opt/some/config.json
```

## Selecting only keys; i.e. like python .keys()
- good when trying to model large json objects
```bash
$ cat node-stats.json | jq keys
[
  "ephemeral_id",
  "events",
  "host",
  "http_address",
  "id",
  "jvm",
  "name",
  "os",
  "pipeline",
  "pipelines",
  "process",
  "queue",
  "reloads",
  "snapshot",
  "status",
  "version"
]
```
- to select keys of a nested object, just pipe to keys
```bash
$ cat node-stats.json | jq '.jvm | keys'
[
  "gc",
  "mem",
  "threads",
  "uptime_in_millis"
]
```
