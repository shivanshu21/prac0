cp /vagrant/apt.conf /etc/apt
sudo -i
apt-get -y update
apt-get -y install git
apt-get -y install screen
apt-get -y install vim
mkdir /root/gitcode
cd /root/gitcode
git clone https://github.com/shivanshu21/prac0.git
cd prac0
chmod 755 cprcfil.sh
./cprcfil.sh
