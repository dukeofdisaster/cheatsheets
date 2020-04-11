# AWS CHEATS
Bits about working with aws stuff
## VPC Peering
- Use Case: I have a script that needs to talk to an api and talk to the company
ActiveDirectory servers to run queries against the domain. 
- I have ec2 in it's own vpc: one pub subnet with IGW with jumpbox, one priv 
subnet where the script will live. 
### Need to Do
1. Need to peer app vpc with AD vpc
2. need to update route table where the script will live (app route table)
3. app route table points to the CIDR of the peer vpc in the peering connection
and has the vpc peering connection as a target
- example
```
APP SUBNET
==========
10.65.10.32/28, 

AD SUBNET
==========
172.16.0.0/24; 

Update App route table
========================
Destination: 172.16.0.0/24 
Target: peering connection that i created earlier

Update AD route table
====================
Destination: 10.65.10.32/28
Target: peering connection that I created earlier
```
TLDR: After the connection is initiated, you have to update both ends of 
the route tables for whatever 2 points/subnets you want to talk to each other

## From ec2 -> s3 
Use case: I have a script running on ec2 that dumps an html file; I want to 
upload this to s3 so it can be hosted as a static site...

## Need to do
I think the right way to do this is to create an IAM svc user that has write
permissions on the bucket, and then use the API to upload that file to the s3. 
If you're gonna use pure api to do the upload, it's gonna be janky and will
require a lot of metadata to make the request.

An easier way would just be to use popen() from the python script to execute
the upload from aws cli.

1. Make sure you have a bucket created to do this, this will be necessary
so our user, security group, and policy can apply only to this bucket
2. create IAM user for programmatic access, create a group and policy that allows r/w on s3
3. On the ec2 instance, run: $ aws configure
- add in acces key id and secret acccess key of IAM user created above
4. Next you need to specify in the bucket policy the user is allowed PutObject
```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AllowServiceUserPutObject",
      "Effect":"Allow",
      "Principal": {"AWS": ["arn:aws:iam::111122223333:user/svc_userwhatever"]},
      "Action":["s3:PutObject"],
      "Resource":["arn:aws:s3:::examplebucket/*"]
    }
  ]
}
```
5. then test from awscli on the ec2
- aws s3 cp somefile s3://examplebucket/

