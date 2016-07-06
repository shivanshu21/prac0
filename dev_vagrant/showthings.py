import os
import sys
import time
import dssSanityLib
from boto.s3.key import Key

###################### MAIN ########################

BUCKETNAME = 'buck999'
def create_stuff():
    global BUCKETNAME
    userObj = dssSanityLib.getConnection()
    b = userObj.create_bucket(BUCKETNAME)
    k = Key(b)
    k.key = 'videofile.flv'
    k.set_contents_from_string('obj which will be downloaded')
    return

def print_obj():
    global BUCKETNAME
    userObj = dssSanityLib.getConnection()
    b = userObj.get_bucket(BUCKETNAME)
    for k in b.list():
        print k
        print k.get_contents_as_string()
    return

def main(argv):

    ## PARAM OVERRIDES
    dssSanityLib.GLOBAL_DEBUG = 0                    # The lib supresses debug logs by default. Override here.
    #dssSanityLib.RADOSHOST = '127.0.0.1'            # The lib points to DSS staging endpoint by default. Override here.
    #dssSanityLib.RADOSPORT = 7480                   # The lib points to DSS staging endpoint by default. Override here.

    ret = dssSanityLib.fetchArgs(argv)
    if(ret == -1):
        sys.exit(2)

## Rename op
    #create_stuff()
    print_obj()


#=========================================
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

#=========================================

    ## Copy object single user workflow
#    userObj = dssSanityLib.getConnection()
#    b = userObj.create_bucket('copysourcebucket')
#    k = Key(b)
#    k.key = 'obj500'
#    k.set_contents_from_string('obj text')
#    c = userObj.create_bucket('copydestbucket')
#    l = c.copy_key('newobj22', 'copysourcebucket', 'obj500')
#    print str(l)
#    print_obj()
#=========================================

    return

if __name__ == "__main__":
    main(sys.argv[1:])

