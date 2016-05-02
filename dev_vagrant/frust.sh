#! /bin/bash
#curl -X PUT -v  -H 'X-Auth-Token: 02949f1cc21a45238bb011f42b02c2d1_27c07263e694485fa2cb1dd522ed72e3' http://localhost:8000/Bucket123

curl -X POST -H 'X-Auth-Token:02949f1cc21a45238bb011f42b02c2d1_27c07263e694485fa2cb1dd522ed72e3' -H 'Content-Type : application/json' -d '{"action_resource_list":[{"action":"jrn:jcs:dss:CreateBucket","resource":"jrn:jcs:dss::Bucket:Bucket123","implicit_allow":"False"}]}' https://iam.ind-west-1.staging.jiocloudservices.com/v3/token-auth
