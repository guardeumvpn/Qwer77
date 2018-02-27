#!/bin/bash
# ******************************************
# Program: Autoscript Setup VPS 2018
# Website: -
# Developer: Disastermaster
# Nickname: DM
# Date: 01-01-2018
# Last Updated: 26-01-2018
# ******************************************
# START SCRIPT ( guardeumvpn.tk )
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
if [ $USER != 'root' ]; then
echo "Sorry, for run the script please using root user"
exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
echo "Sorry, you need to run this as root"
exit 2
fi
if [[ ! -e /dev/net/tun ]]; then
echo "TUN is not available"
exit 3
fi
echo "
AUTOSCRIPT BY DISASTERMASTER

PLEASE CANCEL ALL PACKAGE POPUP

TAKE NOTE !!!"
clear
echo "START AUTOSCRIPT"
clear
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6

COMPLETE 1%
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
REMOVE SPAM PACKAGE

COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
clear
echo "
UPDATE AND UPGRADE PROCESS

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - https://gist.githubusercontent.com/enoch85/092c8f4c4f5127b99d40/raw/186333393163b7e0d50c8d3b25cae4d63ac78b22/jcameron-key.asc | apt-key add -
#wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update;
apt-get -y autoremove;
apt-get -y install wget curl;
echo "
INSTALLER PROCESS PLEASE WAIT

TAKE TIME 5-10 MINUTE
"
# script
wget -O /usr/local/bin/menu "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/menu?token=Ah8GoOMSQKYOqhBVO_-LHL0YKu93ARYtks5ajtNPwA%3D%3D"
wget -O /usr/local/bin/autokill "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/autokill?token=Ah8GoIvoDfouWzKQFk3Vvvn4ks8OrKMEks5ajtNRwA%3D%3D"
wget -O /usr/local/bin/user-generate "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/user-generate?token=Ah8GoKnp8Awc5P7BUhtRbf9XwCoGbMIyks5ajtNSwA%3D%3D"
wget -O /usr/local/bin/speedtest "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/speedtest?token=Ah8GoEeqD5fDLhYlW1SMx3kDhq2HVxHxks5ajtOMwA%3D%3D"
wget -O /usr/local/bin/user-lock "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/user-lock?token=Ah8GoAwaASb78sqBWEHvRIA6HWSL6R5hks5ajtOOwA%3D%3D"
wget -O /usr/local/bin/user-unlock "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/user-unlock?token=Ah8GoFAmrIavyWRR5jvB98gAeisqens2ks5ajtOPwA%3D%3D"
wget -O /usr/local/bin/auto-reboot "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/auto-reboot?token=Ah8GoIDAsOnTAiGTI8V4EwVZ1e0YH1lKks5ajtOtwA%3D%3D"
wget -O /usr/local/bin/user-password "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/user-password?token=Ah8GoIoemEp5UuTMEA_k2rfmMoNHxM1Bks5ajtOuwA%3D%3D"
wget -O /usr/local/bin/trial "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/trial?token=Ah8GoMa1ojTPvMtWzamIuSGruAsL8Z7Oks5ajtPHwA%3D%3D"
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/common-password?token=Ah8GoGZRY-w30c4X42LRJUj-magY7_Nqks5ajtPJwA%3D%3D"
chmod +x /etc/pam.d/common-password
chmod +x /usr/local/bin/menu 
chmod +x /usr/local/bin/autokill 
chmod +x /usr/local/bin/user-generate 
chmod +x /usr/local/bin/speedtest 
chmod +x /usr/local/bin/user-unlock
chmod +x /usr/local/bin/user-lock
chmod +x /usr/local/bin/auto-reboot
chmod +x /usr/local/bin/user-password
chmod +x /usr/local/bin/trial
# fail2ban & exim & protection
apt-get -y install fail2ban sysv-rc-conf dnsutils dsniff zip unzip;
wget https://github.com/jgmdev/ddos-deflate/archive/master.zip;unzip master.zip;
cd ddos-deflate-master && ./install.sh
service exim4 stop;sysv-rc-conf exim4 off;
# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
# ssh
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
wget -O /etc/issue.net "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/banner?token=Ah8GoGGSADreBmkGZHj7TDNdqxi-Tsa3ks5ajtS_wA%3D%3D"
# dropbear
apt-get -y install dropbear
wget -O /etc/default/dropbear "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/dropbear?token=Ah8GoKecYsCGd6DX__oabHUO0yqr7QaJks5ajtThwA%3D%3D"
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
# squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/squid.conf?token=Ah8GoJU4j1WjWI--0ubgsQCQ4F4j2aPkks5ajtTiwA%3D%3D"
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/squid.conf?token=Ah8GoJU4j1WjWI--0ubgsQCQ4F4j2aPkks5ajtTiwA%3D%3D"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid/squid.conf
# openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget -O openvpn.tar "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/openvpn.tar?token=Ah8GoOluALE5DjLPWF-4gkDNPr1-d8ihks5ajtU_wA%3D%3D"
tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/rc.local "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/rc.local?token=Ah8GoA0aZTqB5I1nXg4XeTGodEsHQdODks5ajtU8wA%3D%3D"
chmod +x /etc/rc.local
# nginx
apt-get -y install nginx php-fpm php-mcrypt php-cli libexpat1-dev libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/php/7.0/fpm/pool.d/www.conf "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/www.conf?token=Ah8GoCM6cK9hIhtThNFDveEsmYbTrcJQks5ajtWZwA%3D%3D"
mkdir -p /home/vps/public_html
echo "<pre>Setup By DISASTERMASTER → Call, Whatsapp, Telegram : @guardeumvpn </pre>" > /home/vps/public_html/index.php
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/vps.conf?token=Ah8GoAjuFaMND_O9da_UYeEE4Gj5mehUks5ajtWbwA%3D%3D"
sed -i 's/listen = \/var\/run\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
# etc
wget -O /home/vps/public_html/client.ovpn "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/client.ovpn?token=Ah8GoOIr7HKQ-2DlEJOhHwh9MTI_Ixe4ks5ajtXfwA%3D%3D"
wget -O /home/vps/public_html/client1.ovpn "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/client1.ovpn?token=Ah8GoDT1gtL6RUqtrFm3cDG9rrsoNTKfks5ajtXgwA%3D%3D"
wget -O /etc/motd "https://raw.githubusercontent.com/guardeumvpn/Debian9/master/motd?token=Ah8GoNFvgiXWG-ye2QO2_bMxQP6_dUrYks5ajtXiwA%3D%3D"
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client1.ovpn
useradd -m -g users -s /bin/bash test
echo "test:test" | chpasswd
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm *.sh;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;
clear
# restart service
service ssh restart
service openvpn restart
service dropbear restart
service nginx restart
service php7.0-fpm restart
service webmin restart
service squid3 restart
service squid restart
service fail2ban restart
clear
# END SCRIPT ( guardeumvpn.tk )
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript VPS (guardeumvpn.ml)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo "Powered By DISASTERMASTER → Call, Whatsapp, Telegram : @guardeumvpn"  | tee -a log-install.txt
echo "nginx : http://$myip:80"   | tee -a log-install.txt
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt
echo "OpenVPN  : UDP 1194 (client config : http://$myip/client.ovpn)"  | tee -a log-install.txt
echo "OpenVPN  : TCP 443 (client config : http://$myip/client1.ovpn)"  | tee -a log-install.txt
echo "Squid : 8080"  | tee -a log-install.txt
echo "OpenSSH : 22"  | tee -a log-install.txt
echo "Dropbear : 443"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "AntiDDOS : [on]"  | tee -a log-install.txt
echo "AntiTorrent : [on]"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo "Menu : Type "menu" To Check Menu Script"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TAKE EFFECT !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
