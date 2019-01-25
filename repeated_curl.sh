#!/bin/bash
for i in {1..5}
do
    curl 'http://127.0.0.1:9999/itm/Bulova-Womens-97N101-Quartz-Swarovski-Crystal-Dial-Rose-Gold-Dress-Watch/112244118019' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,hi;q=0.8' -H 'Cookie: JSESSIONID=78EB3988C8515984319526EA1A6D218F; PdsCGuid=1b931ba41680ac3d67fa5dadffffffff; PdsSession=1b931ba41680ac3d67fa5dadffffffff' --compressed
done
