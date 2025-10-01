iptables -t nat -A POSTROUTING -s 10.78.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.78.2.0/24 -o eth0 -j MASQUERADE