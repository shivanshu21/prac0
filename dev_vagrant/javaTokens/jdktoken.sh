wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz"

tar -xvzf jdk-8u77-linux-x64.tar.gz
cp /vagrant/javaTokens/JcsIamKeystoneTest.jar .
cp /vagrant/javaTokens/local_policy.jar jdk1.8.0_77/jre/lib/security/
cp /vagrant/javaTokens/README.txt jdk1.8.0_77/jre/lib/security/
cp /vagrant/javaTokens/US_export_policy.jar jdk1.8.0_77/jre/lib/security/
cd jdk1.8.0_77/bin/

