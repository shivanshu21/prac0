my $signreq = "curl -s -i -X POST https://iam.ind-west-1.staging.jiocloudservices.com:35357/v3/sign-auth -H \"Content-Type: application/json\" -d '{\"credentials\": {\"access\": \"c312c8c23a9e45398003b256759cef05\", \"signature\": \"H/AUlsWSTz7LeeeSDhu2G4m8S+E=\", \"token\": \"R0VUCgoKRnJpLCAwNSBGZWIgMjAxNiAxMTowNjo0NiBHTVQKLw==\", \"action_resource_list\": [{\"action\": \"jrn:jcs:dss:CreateBt\", \"resource\": \"jrn:jcs:dss::Bucket:*\", \"implicit_allow\": \"False\"}]}}'";

my $tokreq = "curl -v -H \"Content-Type: application/json\" -d '{ \"auth\": {\"identity\": {\"methods\": [\"password\"],\"password\": {\"user\": {\"name\": \"dss\",\"domain\": { \"id\": \"08d9079e37ca4750ae1b223af8869f92\" },\"password\":\"Reliance111@\"}}}}}' https://iam.ind-west-1.staging.jiocloudservices.com:35357/v3/auth/tokens ; echo";


my $rgwreq = "curl -v -H \"X-Auth-Token: 1256781450c14c1ea443595998fe3dd7\" http://127.0.0.1:8000/ ; echo";


#exec($signreq);
#exec($tokreq);
exec($rgwreq);
