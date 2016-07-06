import base64
import hmac
from hashlib import sha1
def get_signature(url, secret):
    msg = base64.urlsafe_b64decode(str(url))
    key = str(secret)
    signed = base64.encodestring(hmac.new(key, msg, sha1).digest()).strip()
    return signed

#print get_signature("R0VUCgoKVHVlLCAxMCBNYXkgMjAxNiAxMDozNDowMiBHTVQKLw==", "b5daefbe3ba04565b5fa8c62cb024df0")
print get_signature("R0VUCgoKVHVlLCAxMCBNYXkgMjAxNiAxMDozNDowMyBHTVQKLw==", "b5daefbe3ba04565b5fa8c62cb024df0")
