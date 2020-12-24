# curl tips and tricks
Curl can sometimes be used to send json-formatted get requests
- if application accepts /pages?id=test, try
- $curl -H "content-type: application/json" -X GET http://ptl-811be015-549ac544.libcurl.so/pages -d '{"id":"test"}'


