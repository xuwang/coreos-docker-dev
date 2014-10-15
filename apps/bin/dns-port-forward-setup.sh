#! /bin/bash

#/usr/sbin/sysctl -w net.ipv4.ip_forward=1

# cleanup first
/sbin/iptables -D INPUT -p udp --dport 5353 -j ACCEPT
/sbin/iptables -t nat -D PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5353

# Add port forwarding 53 => 5353
/sbin/iptables -A INPUT -p udp --dport 5353 -j ACCEPT
/sbin/iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5353