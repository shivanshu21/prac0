from Crypto.Cipher import AES
import base64

password = 'Reliance_123'
print "Password    :\"%s\"" % password
pass_length = len(password)
print "pass_length :\"%s\"" % pass_length
password = password.rjust(((pass_length/16)+1)*16)
print "Password    :\"%s\"" % password
secret_key = '39d454a4c4ea4ea1bb7ccdac7c3ba389'
cipher = AES.new(secret_key,AES.MODE_ECB)
print "cipher     :%s" % cipher
encrypt_cipher = cipher.encrypt(password)
print "encrypt_cipher     :%s" % encrypt_cipher
encoded = base64.b64encode(encrypt_cipher)
print "encoded  :   %s" % encoded
