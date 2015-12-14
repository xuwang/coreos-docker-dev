#!/bin/bash
# Delay SYN at the TCP level while we restart haproxy.
iptables -I INPUT -p tcp --match multiport --dports 80,443 --syn -j DROP
sleep 1
/usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg
iptables -D INPUT -p tcp --match multiport --dports 80,443 --syn -j DROP
