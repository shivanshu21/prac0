sudo openconnect --config=./vpn_conf jiovpn.hackalyst.info;
sudo ip route add 10.140.0.0/16 via 0.0.0.0 dev tun0;
sudo ip route add 10.204.122.160/27 via 0.0.0.0 dev tun0; #iLo IP
sudo route add default gw 100.113.0.1 dev wlan0; #Jionet
sudo route add default gw 192.168.1.1 dev wlan0; # Rest Wi Fi
./alive.sh;
