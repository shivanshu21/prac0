#! /bin/bash

## Presigned URL
#curl http://127.0.0.1:8000/rjilbucketsanity1456998632/?Signature=5UiA34ZXNQjNxtS0lqeERAV1sIA%3D\&Expires=1457008634\&AWSAccessKeyId=c312c8c23a9e45398003b256759cef05

## Copy via JCS and AWS headers
#curl -v -X "PUT" -H "X-Auth-Token: 2a6b8a8f576c4a9bb9fbc35f4815881d_deb06b8ab0d3474d9d25fb125535acff" -H "x-jcs-copy-source: cobucket001/obj" -H "x-jcs-metadata-directive: COPY" http://127.0.0.1:8000/cobucket002/adiffnewobj

curl -v -X "PUT" -H "X-Auth-Token: 2a6b8a8f576c4a9bb9fbc35f4815881d_deb06b8ab0d3474d9d25fb125535acff" -H "x-amz-copy-source: cobucket001/obj" -H "x-amz-metadata-directive: COPY" http://127.0.0.1:8000/cobucket002/newobj

## Gen token
#curl -k -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "console_account","account": { "id": "652281179750" },"password": "eblLLz4pj+pPyczEzAs9ZQ==","access":"1376e515a13b459c9e390612b855afc1"}}}}}'  https://iam.ind-west-1.staging.jiocloudservices.com:5000/v3/auth/tokens

#curl -k -i -H "Content-Type: application/json" -d '{ "auth": {"identity": {"methods": ["password"],"password": {"user": {"name": "dss_test_0001","account": { "id": "304018976221" },"password": "D2=lH6-fA2$b","access":"0ef217eff5b146f19759532d3b6ea76a"}}}}}'  "https://iam.ind-west-1.staging.jiocloudservices.com:5000/v3/auth/tokens"
