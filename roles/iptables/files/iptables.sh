#!/bin/bash

# define Interface name 
LAN=eth0

# Get netmask 
LOCALNET_MASK=`ifconfig $LAN|sed -e 's/^.*Mask:\([^ ]*\)$/\1/p' -e d`

# Get localnet address 
LOCALNET_ADDR=`netstat -rn|grep $LAN|grep $LOCALNET_MASK|cut -f1 -d' '`
LOCALNET=$LOCALNET_ADDR/$LOCALNET_MASK

# stop firewall 
/etc/rc.d/init.d/iptables stop

# define default rule 
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# allow loopback 
iptables -A INPUT -i lo -j ACCEPT

# allow the internal access 
iptables -A INPUT -s $LOCALNET -j ACCEPT

# allow respose when the access is from internal 
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#-----------------------------------------
# defind the ports that you want to allow 
#-----------------------------------------

# TCP20,21 FTP
#iptables -A INPUT -p tcp --dport 20 -j ACCEPT
#iptables -A INPUT -p tcp --dport 21 -j ACCEPT

# SSH 
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# HTTP 
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# HTTPS/SSL 
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# For test http Mojolicious
#iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

# For Mosh
#iptables -A INPUT -p udp -m udp --dport 60000:61000 -j ACCEPT

# Save rule, which is affective after reboot
/etc/rc.d/init.d/iptables save

# Start iptable 
/etc/rc.d/init.d/iptables start
