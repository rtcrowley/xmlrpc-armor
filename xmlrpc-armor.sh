#!/bin/bash

#Any IP with gt 99 xmplrpc requests within the current access_log.
#Verify Apache access log path..
num=$(cat /var/log/httpd/access_log |grep "POST /xmlrpc.php" |cut -d' ' -f1 |uniq -c |sort |sort -n |rev |cut -d ' ' -f1-2 \
|rev |awk '$1>99' |awk '{print $2}' |sort |uniq)

#Currently blocked IP's.
ips=$(/sbin/iptables -L INPUT -v -n |awk '{print $8}' |grep -v 0.0.0.0 |grep -v bytes |grep -v source |sort |uniq)

#Store these file where ever you'd like, cleared after every execution.
> /secure/iptab.log
> /secure/new.log

echo "$ips" >> /secure/iptab.log
echo "$num" >> /secure/new.log

#Grep differences between the two
addit=$(grep -vFx -f /secure/iptab.log /home/new.log)

#Drop new ip's found.
for i in $addit; do
 /sbin/iptables -A INPUT -s $i -j DROP
done
