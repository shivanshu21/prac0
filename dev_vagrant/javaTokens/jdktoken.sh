wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz"

tar -xvzf jdk-8u77-linux-x64.tar.gz
cp /vagrant/javaTokens/JcsIamKeystoneTest.jar .
cp /vagrant/javaTokens/local_policy.jar jdk1.8.0_77/jre/lib/security/
cp /vagrant/javaTokens/README.txt jdk1.8.0_77/jre/lib/security/
cp /vagrant/javaTokens/US_export_policy.jar jdk1.8.0_77/jre/lib/security/
cd jdk1.8.0_77/bin/

./java -jar ../../JcsIamKeystoneTest.jar CreateToken C iam.ind-west-1.staging.jiocloudservices.com "" Y 544684726711 dss_console_test01 Reliance__123 239d61b4819b40b7bb37b2a5db0cfa7f 5355aff590b841e48261ee44e8f0ebb5 511054669218 dss_test_0000 Reliance_123
