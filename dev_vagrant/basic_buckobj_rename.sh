#!/bin/bash
if [ "$#" -ne 2 ];
then
	buckName="buck"$RANDOM
	objName="obj"$RANDOM
    newName="obj1"$RANDOM
else
	buckName=$1
	objName=$2
fi

USERNAME="nobody"
ACCID="162791231507"
PASSWORD="8okX0bEtUxQRMkcIqJpCTg=="


USERNAME="dss_test_0000"
ACCID="511054669218"
PASSWORD="oPN40ZyE9D5etjeqGmO1EA=="
ACCESS_KEY="2bf9f42cc7fa47fdae06f14dddd7e4ac"


#===============================
# DO NOT ALTER BEYOND THIS POINT
#===============================
CONS_USERNAME="console_account"
CONS_ACCID="652281179750"
CONS_PASSWORD="eblLLz4pj+pPyczEzAs9ZQ=="
CONS_ACCESS_KEY="1376e515a13b459c9e390612b855afc1"
IAM_URL="https://iam.ind-west-1.staging.jiocloudservices.com/auth/tokens"
#host="https://dss.ind-west-1.staging.jiocloudservices.com"
host="127.0.0.1:8000"
#=================
#   COMMANDS
#=================
ErrorHandling() {
	#echo "$1"
	#echo "$2"
	error=$(echo "$1" | grep -i "error")
	if [ -n "$error" ]; then
		echo "ERROR FOUND in $2, exiting $2:: FAILED"
		exit
	else 
		echo "$2 :: PASSED"
	fi
		
}
result1=$(curl -k -v -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$USERNAME"'","account": { "id": "'"$ACCID"'" },"password": "'"$PASSWORD"'","access":"'"$ACCESS_KEY"'"}}}}}'  $IAM_URL | grep "X-Subject-Token:")
arr=$(echo $result1 | tr ":" "\n")
for x in $arr
do
    token1=$x
done

if [ -n "$token1" ]; then
	echo " DSS Token generated successfully :: "$token1
else
	echo "DSS user Token generation failed thus exiting"
	exit
fi

result=$(curl -k -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$CONS_USERNAME"'","account": { "id": "'"$CONS_ACCID"'" },"password": "'"$CONS_PASSWORD"'","access":"'"$CONS_ACCESS_KEY"'"}}}}}'  $IAM_URL | grep "X-Subject-Token:")

echo "output result::"
echo $result

arr=$(echo $result | tr ":" "\n")

for x in $arr
do
    token2=$x
done

if [ -n "$token2" ]; then
	echo "Console Token generated successfully :: "$token2
else
	echo " Console Token generation failed thus exiting"
	exit
fi
#echo ${token1}
#echo ${token2}

name2="${token2//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
echo $name2
name="${token1//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
echo $name
echo $output

str="{\"duration\" :360000, \"resource\": \"jrn:jcs:dss::Bucket:${buckName}\", \"action\": \"jrn:jcs:dss:GetObject\", \"object_name\": \"${objName}\"}"
echo $str

echo "Sample date" > sampleFile

echo "#############################Creating a bucket and an object and getting the same object######################################################################"

curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}"
curl -v -k -X "PUT" -T "sampleFile" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}"
result1=$(curl -v -o outobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}")
echo $result1
#result=$(curl -k -i -H "Content-Type: application/json" -H "X-Auth-Token: ${name}" -d '{ "resource": "jrn:jcs:dss:08d9079e37ca4750ae1b223af8869f92:Bucket:raj1",  "action": "jrn:jcs:dss:GetObject", "object_id": "obj1"}' "https://iam.ind-west-1.staging.jiocloudservices.com/preauth-token" | grep "X-Preauth-Token:")


echo "#############################Renaming an object and getting the same object######################################################################"
curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}?newname=${newName}"

result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}")
testdesc= "trying to get the old object which should be deleted"
ErrorHandling $result1 $testdesc

result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}")
testdesc= "trying to get the renamed object"
ErrorHandling $result1 $testdesc
exit

result1=$(curl -v -k -X "PUT" -H "X-Auth-Token: ${name2}"  "${host}/${buckName}/${objName}?newname=${newName}")
testdesc="Trying to rename without IAM permissions"
ErrorHandling $result1 $testdesc

result1=$(curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}${RANDOM}/${objName}?newname=${newName}")
testdesc="Trying to rename with invalid bucket"
ErrorHandling $result1 $testdesc


result1=$(curl -v -k -X "PUT" -T "sampleFile" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}$RANDOM?newname=${newName}")
testdesc="Trying to rename with invalid object"
ErrorHandling $result1 $testdesc

result1=$(curl -v -k -X "POST" -T "sampleFile" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}?newname=${newName}")
testdesc="Trying to rename with POST"
ErrorHandling $result1 $testdesc

result1=$(curl -v -k -X "GET" -T "sampleFile" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}?newname=${newName}")
testdesc="Trying to rename with GET"
ErrorHandling $result1 $testdesc

#./ceph --admin-daemon /home/obj_team/ceph/src/out/client.admin.30046.asok config set fault_inj_rename_op_copy_fail true

newName1=${newName}$RANDOM


result1=$(curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}?newname=${newName1}")
testdesc="Trying to rename with after faulting copy"
ErrorHandling $result1 $testdesc


result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}")
testdesc= "trying to get the original object after failing copy"
ErrorHandling $result1 $testdesc


result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName1}")
testdesc= "Checking if there is no ghost object"
ErrorHandling $result1 $testdesc

./ceph --admin-daemon /home/obj_team/ceph/src/out/client.admin.30046.asok config set fault_inj_rename_op_copy_fail false

./ceph --admin-daemon /home/obj_team/ceph/src/out/client.admin.30046.asok config set fault_inj_rename_op_delete_fail true

result1=$(curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}?newname=${newName1}")
testdesc="Trying to rename with after faulting delete"
ErrorHandling $result1 $testdesc


result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}")
testdesc= "trying to get the original object after failing delete"
ErrorHandling $result1 $testdesc


result1=$(curl -v -o outrenameobj -k -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName1}")
testdesc= "Checking if there is no ghost object"
ErrorHandling $result1 $testdesc

