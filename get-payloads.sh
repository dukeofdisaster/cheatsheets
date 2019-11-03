#!/bin/bash
#
# faster than running the msfvenom script to list payloads
# supply a an arg and grep it out; enter the payload file path
payloadfile=msfvenom-payloads
grep $1 $payloadfile
