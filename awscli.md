# AWS CLI CHEAT SHEET
## COMMANDS

```aws configure```
- setup the aws cli; i.e. add access key id and secret

```aws s3 ls ```
- list s3 buckets you have access to

```aws s3 mb <somebucket>```
- make a bucket with a given name

```aws s3 cp /tmp/dude.txt s3://mybuckethere```
- copy file into the target bucket (i.e. like a dir)

```aws s3 ls s3://dudewheresmycar```
- list files in the s3 bucket "dudewheresmycar"
