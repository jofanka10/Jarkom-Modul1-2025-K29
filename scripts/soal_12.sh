# Setup di Node Melkor :
ss -ltnp | grep :21
# kalau tidak ada, restart
service vsftpd restart

echo "File uji FTP dari Melkor" > /home/eru_test/penting.txt
chown eru_test:eru_test /home/eru_test/penting.txt
ls -l /home/eru_test/penting.txt

service vsftpd restart

capture wireshark dari eru melkor 
display filter : tcp && ip.addr==10.78.1.2
 
Masuk ke node eru :

echo "nameserver 8.8.8.8" > /etc/resolv.conf

apt-get update
apt-get install -y netcat-openbsd

# scan port :
for p in 21 80 666; do
  echo "=== Port $p ==="
  nc -vz -w2 10.78.1.2 $p 2>&1
done | tee /tmp/scan_result.txt

# === Port 21 ===
# Connection to 10.78.1.2 21 port [tcp/ftp] succeeded!
# === Port 80 ===
# nc: connect to 10.78.1.2 port 80 (tcp) failed: Connection refused
# === Port 666 ===
# nc: connect to 10.78.1.2 port 666 (tcp) failed: Connection refused
# root@Eru:~#
