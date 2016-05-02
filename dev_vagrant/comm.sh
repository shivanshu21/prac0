#! /bin/bash

## Presigned URL
#curl http://127.0.0.1:8000/rjilbucketsanity1456998632/?Signature=5UiA34ZXNQjNxtS0lqeERAV1sIA%3D\&Expires=1457008634\&AWSAccessKeyId=c312c8c23a9e45398003b256759cef05

## Copy via JCS and AWS headers
#curl -v -X "PUT" -H "X-Auth-Token: b12f8402857f4ac3ba58bf4e13a58633_b12f8402857f4ac3ba58bf4e13a58633" -H "x-jcs-copy-source: cobucket001/obj" -H "x-jcs-metadata-directive: COPY" http://127.0.0.1:8000/cobucket002/adiffnewobj

#curl -v -X "PUT" -H "X-Auth-Token: 2a6b8a8f576c4a9bb9fbc35f4815881d_deb06b8ab0d3474d9d25fb125535acff" -H "x-amz-copy-source: cobucket001/obj" -H "x-amz-metadata-directive: COPY" http://127.0.0.1:8000/cobucket002/newobj








## IAM resource based policies

#buck="buck891"


#jcs iam CreateResourceBasedPolicy --PolicyDocument "{\"name\": \"GetTUbuck\", \"statement\": [{\"action\": [\"jrn:jcs:dss:ListBucket\"], \"principle\": [\"jrn:jcs:iam:319505121107:User:shivanshu\"], \"effect\": \"allow\"}]}"
#policyid="7efbdaf1434d4ffeaef56aeeec3ba325"

#jcs iam CreateResourceBasedPolicy --PolicyDocument "{\"name\": \"GetTUObject\", \"statement\": [{\"action\": [\"jrn:jcs:dss:GetObject\"], \"principle\": [\"jrn:jcs:iam:319505121107:User:shivanshu\"], \"effect\": \"allow\"}]}"
#policyid="056daf2f3f8e4a098d4df2b999934a2a"

#jcs iam CreateResourceBasedPolicy --PolicyDocument "{\"name\": \"PersGetObject\", \"statement\": [{\"action\": [\"jrn:jcs:dss:GetObject\"], \"principle\": [\"jrn:jcs:iam:713268835218:User:shivanshu\"], \"effect\": \"allow\"}]}"
#policyid="19a0607d61c5411094af49802d24404c"



#jcs iam AttachPolicyToResource --PolicyId $policyid --Resource "{\"resource\": [\"jrn:jcs:dss:713268835218:Bucket:$buck\"]}"

#jcs iam DetachPolicyFromResource --PolicyId $policyid --Resource "{\"resource\": [\"jrn:jcs:dss:713268835218:Bucket:$buck\"]}"
#jcs iam DeleteResourceBasedPolicy --Id $policyid
