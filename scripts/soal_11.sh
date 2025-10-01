apt update
apt install vsftpd

adduser eru_test

# Buat file uji di home user
echo "File uji FTP dari Melkor" > /home/eru_test/penting.txt
chown eru_test:eru_test /home/eru_test/penting.txt
ls -l /home/eru_test/penting.txt

cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
cat <<'EOF' > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
EOF

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

service vsftpd restart
service vsftpd status

# hidupkan capture wireshar di jaringan melkor

# di node eru :

ftp 10.78.1.2

# login eru_test

ftp> ls
ftp> get penting.txt
ftp> quit

# stop capture wireshark

# hasilnya :
# 6	2025-10-02 01:16:19.676813	10.78.1.1	10.78.1.2	FTP	81	Request: USER eru_test
# 10	2025-10-02 01:16:22.462728	10.78.1.1	10.78.1.2	FTP	81	Request: PASS eru_test

    
