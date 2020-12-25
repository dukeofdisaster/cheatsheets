# Painless scripting examples. 
Note These were ran on 7.10 Version; if there's any diff between later versions
but whatever. 

Also note, when possible you should handle such modifications at ingest time.
This might not always be possible; for example if you're tagging data tied
to malicious IP addresses that you've learned about after the fact. 

## Split a string field 
```
POST /wip-tasks*/_update_by_query?wait_for_completion=false
{
  "script": {
    "source": "def split_node=ctx._source['tasks']['task_id'].splitOnToken(':'); ctx._source['tasks']['node_id'] = split_node[0]; ctx._source['tasks']['task_num'] = split_node[1];",
    "lang": "painless"
  },
  "query": {
    "match_all": {}
  }
}
```

## Same split but with parseInt
```
POST /wip-tasks*/_update_by_query?wait_for_completion=false
{
  "script": {
    "source": "def split_node=ctx._source['tasks']['task_id'].splitOnToken(':'); ctx._source['tasks']['node_id'] = split_node[0]; ctx._source['tasks']['task_num'] = Integer.parseInt(split_node[1]);",
    "lang": "painless"
  },
  "query": {
    "match_all": {}
  }
}
```

## Modify a variable value
```
POST /suricata-flow*/_update_by_query?wait_for_completion=false
{
  "script": {
    "source": "ctx._source.input.type = 'xx'",
    "lang": "painless"
  },
  "query": {
    "match_all": {}
  }
}
```
