apt update
apt install vsftpd -y

mkdir -p /srv/ftp/sharing
chown ftp:ftp /srv/ftp/sharing

adduser ainur
adduser melkor

usermod -d /srv/ftp/sharing ainur
chown ainur:ainur /srv/ftp/sharing
chmod 700 /srv/ftp/sharing

nano /etc/vsftpd.conf
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES

service vsftpd restart
ftp 192.168.122.114

# (tes login)

# di eru :
echo "Halo dari FTP server" | tee /srv/ftp/sharing/test.txt

di node lain :
ftp 192.168.122.114
login user ainur
ls
get test.txt
put coba.txt
exit

login user melkor
ls
cd sharing