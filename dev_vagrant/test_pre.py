import concurrent.futures
import random
import threading
import time
import boto
import boto.s3.connection
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("access")
parser.add_argument("secret")
args = parser.parse_args()
access_key = args.access
secret_key = args.secret

conn = boto.connect_s3(
        aws_access_key_id = access_key,
        aws_secret_access_key = secret_key,
        #host = 'dss.ind-west-1.internal.jiocloudservices.com',
        host = '10.140.214.195',
        port = 8000,
        is_secure=False,
        validate_certs=False,
        calling_format = boto.s3.connection.OrdinaryCallingFormat(),
        debug=3,
        )


#bucket = conn.get_bucket('rjilbucketsanity14563229671')
#for key in bucket.list():
#    print key.name
#    print key.name + " : " + key.generate_url(108000, query_auth=True, force_http=False)
#bucket = conn.get_bucket('write.rgw.9.user99')
#for key in bucket.list():
#    object_name = key.name
#    print object_name
#key = bucket.get_key('test5object1k79504')
#print key.generate_url(3600, query_auth=True, force_http=False)

#print conn.get_all_buckets()
bucket = conn.create_bucket('dss.certs.bucket')
#key = bucket.new_key('dss.crt')
#key.set_contents_from_filename('/usr/local/share/ca-certificates/selfsigned.crt')
#print key.generate_url(864000, method='GET', query_auth=True, force_http=False)
print conn.get_all_buckets()
exit()
#print conn.https_validate_certificates
#b=conn.create_bucket('test_bucket_harshal-1')
#b=conn.delete_bucket('test_bucket_harshal-1')
for bucket in conn.get_all_buckets():
    #clean_bucket(bucket.name)
    bucket_name = bucket.name
    print "===" + bucket_name + "==="
    #executor.submit(clean_bucket, bucket_name)
    #delete all objects and delete bucket
    for key in bucket.list():
        object_name = key.name
        print object_name
        #bucket.delete_key(object_name) 

    #conn.delete_bucket(bucket_name)

#print b
#executor.shutdown(wait=True)
