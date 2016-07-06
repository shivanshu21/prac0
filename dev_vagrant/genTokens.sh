#!/bin/bash

#=================
#   PROFILES
#=================
#USERNAME="dss"
#ACCID="08d9079e37ca4750ae1b223af8869f92"
#PASSWORD="L+kMBnSzk2KiMYITAP+RQQ=="

#USERNAME="nobody"
#ACCID="162791231507"
#PASSWORD="8okX0bEtUxQRMkcIqJpCTg=="

#USERNAME="dss_test_0000"
#ACCID="511054669218"
#PASSWORD="D2=lH6-fA2\\\$b"

USERNAME="dss_test_0000"
ACCID="511054669218"
PASSWORD="3d2+PNOruj6rrke7rSGhlA=="

#===============================
# DO NOT ALTER BEYOND THIS POINT
#===============================
CONS_USERNAME="console_account"
CONS_ACCID="652281179750"
CONS_PASSWORD="eblLLz4pj+pPyczEzAs9ZQ=="
CONS_ACCESS_KEY="1376e515a13b459c9e390612b855afc1"
IAM_URL="https://iam.ind-west-1.staging.jiocloudservices.com/auth/tokens"

#=================
#   COMMANDS
#=================
result1=$(curl -k -v -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$USERNAME"'","account": { "id": "'"$ACCID"'" },"password": "'"$PASSWORD"'","access":"'"$CONS_ACCESS_KEY"'"}}}}}' $IAM_URL | grep "X-Subject-Token:")
arr=$(echo $result1 | tr ":" "\n")
for x in $arr
do
    token1=$x
done

result=$(curl -k -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$CONS_USERNAME"'","account": { "id": "'"$CONS_ACCID"'" },"password": "'"$CONS_PASSWORD"'","access":"'"$CONS_ACCESS_KEY"'"}}}}}'  $IAM_URL | grep "X-Subject-Token:")
arr=$(echo $result | tr ":" "\n")
for x in $arr
do
    token2=$x
done

name2="${token2//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
name="${token1//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
echo "console_console: " $name2
echo "token_console: " $name

#=====================================
#   INFINITE TIME PRESIGNED URL TOKEN
#=====================================
##Infinite time presigned URL
#curl -k -i -X POST -H "Content-Type: application/json" -H "X-Auth-Token: $name" -d '{"resource": "jrn:jcs:dss:511054669218:Bucket:bucket789", "action": "jrn:jcs:dss:GetObject", "object_id": "frust"}'  "https://iam.ind-west-1.staging.jiocloudservices.com/preauth-token"
