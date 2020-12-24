# Elastic - tasks
- Get a list of tasks
```
GET /_cat/tasks
```

- Get an individual task
```
GET /_tasks/<taskid>
```

- Cancel a task
```
POST /_tasks/<taskid>/_cancel
```

- Cancel all reindex tasks on a a given node
```
POST /_tasks/_cancel?nodes=nodeID1,nodeID2&actions=*reindex
```

- Cancel all search tasks ona given node
	- This can be useful if you have an odd issue where 1 node has massive CPU spike
	and tasks show high number of long tasks
```
POST /_tasks/_cancel?nodes=nodeID1,nodeID2&actions=*search
```
