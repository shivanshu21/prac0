echo "========================== Configuring HTTP proxy"
sudo -i
cp /vagrant/apt.conf /etc/apt
export http_proxy=10.140.221.232:3128
export https_proxy=$http_proxy
export no_proxy="127.0.0.1, localhost"

echo "========================== Installing software"
apt-get -y update
apt-get -y install git
apt-get -y install screen

echo "========================== Making directories"
mkdir /root/gitcode
cd /root/gitcode

echo "========================== Getting Git code and running"
git config --global user.name "Shivanshu Goswami"
git config --global user.email "shivanshu.goswami@ril.com"
git clone https://github.com/shivanshu21/prac0.git
cd prac0
chmod 755 cprcfil.sh
./cprcfil.sh
