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

generateToken() {
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
    result1=$(curl -k -v -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$USERNAME"'","account": { "id": "'"$ACCID"'" },"password": "'"$PASSWORD"'","access":"'"$ACCESS_KEY"'"}}}}}'  $IAM_URL | grep "X-Subject-Token:")
    arr=$(echo $result1 | tr ":" "\n")
    for x in $arr
    do
        token1=$x
    done

    result=$(curl -k -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "'"$CONS_USERNAME"'","account": { "id": "'"$CONS_ACCID"'" },"password": "'"$CONS_PASSWORD"'","access":"'"$CONS_ACCESS_KEY"'"}}}}}'  $IAM_URL | grep "X-Subject-Token:")

    #echo "output result::"
    #echo $result

    arr=$(echo $result | tr ":" "\n")

    for x in $arr
    do
        token2=$x
    done

    #echo ${token2}

    name2="${token2//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
    name="${token1//[[:cntrl:]]/}_${token2//[[:cntrl:]]/}"
    echo $name
}

name=$(generateToken)

str="{\"duration\" :360000, \"resource\": \"jrn:jcs:dss::Bucket:${buckName}\", \"action\": \"jrn:jcs:dss:GetObject\", \"object_name\": \"${objName}\"}"
echo $str

echo "Sample date" > sampleFile

echo "#############################Creating a bucket and an object and getting the same object######################################################################"

curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}"
###################change the number of iterations in this########################
START_TIME=$SECONDS
for x in {1..5}
do
    ELAPSED_TIME=$(($SECONDS - $START_TIME))
    if ["$ELAPSED_TIME" -gt 3000]
    then 
        name=$(generateToken)
    fi
    objName="obj"$RANDOM
    newName="obj1"$RANDOM
    curl -v -k -X "PUT" -T "sampleFile" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}"
    curl -v -k -X "PUT" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}?newname=${newName}"
    curl -v -k -o outf -X "GET" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${objName}"
    if [[ $(diff sampleFile outf) ]]; then
        echo "GET obj test :: <Error> Failed, inconsistency in data, or object not present"
    else
        echo "GET obj test :: Successful PASSED"
    fi

    curl -v -k -X "DELETE" -H "X-Auth-Token: ${name}"  "${host}/${buckName}/${newName}"
    
done

