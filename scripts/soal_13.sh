# di eru :
apt-get update
apt-get install -y openssh-server

# cek ip
ip a
# pastikan sshd jalan
service ssh restart
service ssh status   # atau: ps aux | grep sshd
ss -ltnp | grep :22

adduser admin_erux

ssh admin_erux@192.168.122.114

# lalu capture wireshark melalui varda 
# display filters :
tcp.port == 22

