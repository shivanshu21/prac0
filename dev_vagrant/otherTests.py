import os
import sys
import time
import dssSanityLib
from boto.s3.key import Key

###################### MAIN ########################

def main(argv):

    ## PARAM OVERRIDES
    dssSanityLib.GLOBAL_DEBUG = 1                    # The lib supresses debug logs by default. Override here.
    #dssSanityLib.RADOSHOST = '127.0.0.1'            # The lib points to DSS staging endpoint by default. Override here.
    #dssSanityLib.RADOSPORT = 7480                   # The lib points to DSS staging endpoint by default. Override here.

    ret = dssSanityLib.fetchArgs(argv)
    if(ret == -1):
        sys.exit(2)


    ## Cross account copy
#    BUCKETNAME = 'buck668'
#    userObj = dssSanityLib.getConnection(1) ##pers
##    dssSanityLib.cleanupUser(userObj, BUCKETNAME)
#    b = userObj.create_bucket(BUCKETNAME)
#    k = Key(b)
#    k.key = 'tobecopiedobj'
#    k.set_contents_from_string('I used to be in buck667')

#    anObj = dssSanityLib.getConnection(0) ##shiv test
##    dssSanityLib.cleanupUser(anObj, BUCKETNAME)
#    c = anObj.create_bucket(BUCKETNAME + 'buckwow18')
#    l = c.copy_key('dest1', BUCKETNAME, 'tobecopiedobj')
#    print str(l)


## Bucket create and cross account access
    BUCKETNAME = 'buck888'
    userObj = dssSanityLib.getConnection(0)
    b = userObj.create_bucket(BUCKETNAME)
    k = Key(b)
    k.key = 'obj'
    k.set_contents_from_string('obj which will be downloaded from cross account')

    user2 = dssSanityLib.getConnection(1)
    c = user2.get_bucket(BUCKETNAME)
#    j = Key(c)
#    j.key = 'obj'
#    try:
#        print j.get_contents_as_string()
#    except:
#        print "IAM did not validate get object when cross account get bucket is allowed."



    ## Copy object single user workflow
#    userObj = dssSanityLib.getConnection()
#    b = userObj.create_bucket('copysourcebucket')
#    k = Key(b)
#    k.key = 'obj500'
#    k.set_contents_from_string('obj text')
#    c = userObj.create_bucket('copydestbucket')
#    l = c.copy_key('newobj', 'copysourcebucket', 'obj500')
#    print str(l)

    return

if __name__ == "__main__":
    main(sys.argv[1:])

####################################################
'''
#    userObj.create_bucket('bucket0');
#    userObj.create_bucket('bucket1');
#    userObj.create_bucket('bucket2');
#    userObj.create_bucket('bucket3');
#    userObj.create_bucket('bucket4');
#    userObj.create_bucket('bucket5');
#    userObj.create_bucket('bucket6');
#    userObj.create_bucket('bucket7');
#    userObj.create_bucket('bucket8');
#    userObj.create_bucket('bucket9');

'''


'''
    #print userObj.get_all_buckets();
    b = userObj.get_bucket('shivbucket0002');
    k = Key(b)
    k.key = 'obj501'
    #k.set_contents_from_string('obj500 sample text')
    out = k.get_contents_as_string()
    print "Obj has: " + str(out)
    #k.delete()

    # Copy object workflow
    b = userObj.create_bucket('copysourcebucket')
    k = Key(b)
    k.key = 'obj500'
    k.set_contents_from_string('obj text')

    c = userObj.get_bucket('copydestbucket')
    l = c.copy_key('obj', 'copysourcebucket', 'obj')
    print str(l)
'''

