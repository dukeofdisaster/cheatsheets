#!/bin/bash
#
# Script to try all standard and two jibberesh 
# methods on an endpoint
# REQUIRES: curl
#
if [[ $1 = "" ]]; then
  echo "Usage: $0 http://website.com [-v]"
  exit 1
fi

# See what options it gives us
curl -vX OPTIONS $1

## if non verbose, omit verbose
if [[ $2 = "-v" ]]; then
  curl -vX CONNECT 
  echo "#################"
  curl -vX DELETE $1/nonexistent.txt
  echo "#################"
  curl -vX GET $1
  echo "#################"
  curl -vX HEAD $1
  echo "#################"
  curl -vX OPTIONS $1
  echo "#################"
  curl -vX PATCH $1
  echo "#################"
  curl -vX PUT $1
  echo "#################"
  curl -vX POST $1
  echo "#################"
  echo submitting bulshit method BOB
  echo "#################"
  curl -X BOB $1
  echo "#################"
  exit 0
fi

# else we can just do it without verbose
curl -X CONNECT 
echo "#################"
curl -X DELETE $1/nonexistent.txt
echo "#################"
curl -X GET $1
echo "#################"
curl -X HEAD $1
echo "#################"
curl -X OPTIONS $1
echo "#################"
curl -X PATCH $1
echo "#################"
curl -X PUT $1
echo "#################"
curl -X POST $1
echo "#################"
echo submitting bulshit method BOB
echo "#################"
curl -X BOB $1
echo "#################"
exit 0

