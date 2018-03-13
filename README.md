# xmlrpc-armor

A script to block brute force XMLRPC amplification attacks against your Linux Apache HTTPD server. Setting this up as a cronjob will check your httpd access log for xmlrpc requests and if they are greater than 99 from a given address the ip will be blocked via iptables. Update access log path and xmlrpc count to reflect your server.

