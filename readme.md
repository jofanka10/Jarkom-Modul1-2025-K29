# Laporan Resume Jarkom Modul 1

Anggota
| Nama | NRP |
|------|---------|
| Christiano Ronaldo Silalahi | 5027241025 |
| Jofanka Al-Kautsar Pangestu Abady | 5027241107 |


## No. 1 - 3
Pertama-tama, kita akan membuat Eru sebagai router, lalu membuat 2 switch, dimana setiap swtich mempunyai 2 client, dengan switch 1 mempunyai client yang bernama Melkor dan Manwe dan switch 2 mempunyai client yang bernama Varda dan Ulmo.

Selanjutnya, setiap node dihubungkan, dengan Eru terhubung ke NAT. Lalu, server dinyalakan. Untuk tampilannya seperti ini.

<img width="1098" height="702" alt="Screenshot 2025-10-04 at 14 11 52" src="https://github.com/user-attachments/assets/188e2c78-d19c-43b4-bc20-7898053076ce" />

## No. 4
Agar setiap client tdapat terhubung ke internet, konfigurasi router dan client diperlukan. Untuk network configuration Eru seperti ini.

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.78.1.1
	netmask 255.255.255.0
        post-up iptables -t nat -A POSTROUTING -s 10.78.1.0/24 -o eth0 -j MASQUERA

auto eth2
iface eth2 inet static
	address 10.78.2.1
	netmask 255.255.255.0
        post-up iptables -t nat -A POSTROUTING -s 10.78.2.0/24 -o eth0 -j MASQUERADE
```

Lalu, untuk Ainur (client) seperti ini.
**Melkor**
```
auto eth0
iface eth0 inet static
	address 10.78.1.2
	netmask 255.255.255.0
	gateway 10.78.1.1
```

**Manwe**
```
auto eth0
iface eth0 inet static
	address 10.78.1.3
	netmask 255.255.255.0
	gateway 10.78.1.1
```

**Varda**
```
auto eth0
iface eth0 inet static
	address 10.78.2.2
	netmask 255.255.255.0
	gateway 10.78.2.1
```

**Ulmo**
```
auto eth0
iface eth0 inet static
	address 10.78.2.3
	netmask 255.255.255.0
	gateway 10.78.2.1
```

Setelah itu, agar dapat terhubung satu sama lain, kita memerlukan `iptables`. Untuk commandnya seperti ini. Namun sebelum itu, jika kita ingin menjalankannya di terminal, kita perlu menggunakan `telnet` agar dapat terhubung. Jika berhasil maka tampilannya akan seperti ini (Manwe).

<img width="496" height="121" alt="Screenshot 2025-10-04 at 14 29 39" src="https://github.com/user-attachments/assets/0f0900e4-efe8-4f79-b50e-5b9d70a742e3" />

Untuk kode `iptables` seperti ini`. 

```
iptables -t nat -A POSTROUTING -s 10.78.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.78.2.0/24 -o eth0 -j MASQUERADE
```
Jika tidak berhasil, maka user dapat menjalankan `apt update` dan `apt install iptables`. Jika `iptables` berhasil dijalankan, kita bisa menghubungkan Eru dengan para Ainur. Untuk hasilnya seperti ini.





## No. 5
<p> Ainur terkuat Melkor tetap berusaha untuk menanamkan kejahatan ke dalam Arda (Bumi). Sebelum terjadi kerusakan, Eru dan para Ainur lainnya meminta agar semua konfigurasi tidak hilang saat semua node di restart.</p>
agar konfigurasi tidak hilang maka bisa disimpan di .bashrc, jadi ketika file ini dijalankan semua konfigurasi yang tersimpan akan dijalankan kembali : (berikut adalah contoh isi dari .bashrc)
<img width="1262" height="557" alt="image" src="https://github.com/user-attachments/assets/a4da1e5f-fe70-44ef-9b75-2fe5cede0b23" />

## No. 6
Setelah semua Ainur terhubung ke internet, Melkor mencoba menyusup ke dalam komunikasi antara Manwe dan Eru. Jalankan file berikut (link file) lalu lakukan packet sniffing menggunakan Wireshark pada koneksi antara Manwe dan Eru, lalu terapkan display filter untuk menampilkan semua paket yang berasal dari atau menuju ke IP Address Manwe. Simpan hasil capture tersebut sebagai bukti. 

Langkah pertama yang dilakukan ialah mendownload file tersebut, lalu buka scriptnya. copy isi scriptnya dan ketik 
```
nano traffic.sh
```
ketik ini di melkor, setelah itu paste scriptnya:

<img width="962" height="445" alt="image" src="https://github.com/user-attachments/assets/817c5472-2646-4e35-9002-41f4e1f9b5a8" />

setelah itu save dan ubah filenya menjadi executable, dengan cara:

```
chmod +x traffic.sh	
```
Lalu mulai capture wiresharknya: (pilih jaringan melkor) 

<img width="312" height="284" alt="image" src="https://github.com/user-attachments/assets/80d8e334-de60-4363-9a5c-7124a9147c39" />

pilih start capture, lalu jalankan file traffic.sh dengan cara :

```
./traffic.sh
```
maka akan muncul tampilan seperti ini :

<img width="557" height="121" alt="image" src="https://github.com/user-attachments/assets/ef344c55-ad9b-4413-9b2f-f2c9bcd72e56" />

setelah itu stop capture dan masuk ke wireshark untuk display filter : 
```
ip.addr == 10.78.1.3
```
<img width="1908" height="721" alt="image" src="https://github.com/user-attachments/assets/64670b4d-026f-4a64-91f7-f991101c5f94" />

## No. 7
Untuk meningkatkan keamanan, Eru memutuskan untuk membuat sebuah FTP Server di node miliknya. Lakukan konfigurasi FTP Server pada node Eru. Buat dua user baru: ainur dengan hak akses write&read dan melkor tanpa hak akses sama sekali ke direktori shared. Buktikan hasil tersebut dengan membuat file teks sederhana kemudian akses file tersebut menggunakan kedua user.
Pembaruan Sistem dan Instalasi vsftpd:
```
apt update
apt install vsftpd -y
```
Direktori sharing dibuat, dan kepemilikan awalnya diberikan kepada pengguna ftp agar vsftpd dapat beroperasi.
```
mkdir -p /srv/ftp/sharing
chown ftp:ftp /srv/ftp/sharing
```
Dua pengguna baru, Ainur dan Melkor, dibuat dengan cara :
```
adduser ainur
adduser melkor
```
Pengguna Ainur diatur agar home directory-nya langsung menuju ke direktori shared. Kepemilikan dan hak akses kemudian disesuaikan untuk Ainur agar memiliki hak rwx (read, write, execute) pribadi.
```
usermod -d /srv/ftp/sharing ainur
chown ainur:ainur /srv/ftp/sharing
chmod 700 /srv/ftp/sharing
```
setelah itu modifikasi file konfigurasi vsftpd :
```
nano /etc/vsftpd.conf 
```
isikan dengan :
```
local_enable	YES	Mengizinkan login untuk pengguna lokal.
write_enable	YES	Mengizinkan perintah FTP untuk modifikasi file (upload/delete).
chroot_local_user	YES	Mengunci pengguna lokal di home directory mereka (membatasi akses ke direktori root).
allow_writeable_chroot	YES	Mengizinkan penggunaan chroot meskipun direktori root FTP dapat ditulis (penting agar Ainur dapat mengunggah file).
```
Setelah perubahan, layanan vsftpd di-restart untuk menerapkan konfigurasi baru:

```
service vsftpd restart
```
Pembuktian Hasil :
File test.txt dibuat di direktori bersama:
```
echo "Halo dari FTP server" | tee /srv/ftp/sharing/test.txt
```
Uji Akses Pengguna Ainur (Write & Read) :
di eru :
```
echo "Halo dari FTP server" | tee /srv/ftp/sharing/test.txt
```
ini membuat fan memasukkan file ke direktori sharing, setelah itu coba untuk masuk ke ftp melalui node lain. Login user :
```
ftp 192.168.122.114
```
login user ainur dan coba ls
<img width="801" height="119" alt="image" src="https://github.com/user-attachments/assets/06f6ebbf-45af-4311-b4e2-d86ccc80ebce" />
get test.txt :
<img width="1452" height="164" alt="image" src="https://github.com/user-attachments/assets/add914b8-d15b-4e00-a7f7-03fb1a9445f0" />

lalu coba user melkor yang tidak bisa akses apa-apa :
```
ftp 192.168.122.114
```
login user melkor dan  :
```
cd sharing
```
<img width="425" height="74" alt="image" src="https://github.com/user-attachments/assets/32841f82-4c79-4f1f-a71a-87a9bb66c5a7" />

## No. 8
<p>
Ulmo, sebagai penjaga perairan, melakukan pengiriman data ramalan cuaca ke node <b>Eru</b> melalui protokol FTP.
Proses ini menggunakan akun <code>ainur</code> sebagai client FTP untuk mengunggah file <code>cuaca.txt</code>.
</p>

<h3> Langkah-langkah</h3>
<ol>
  <li>Membuat file berisi ramalan cuaca:
    <pre><code>echo "Dengarlah gemuruh dari kedalaman, ...
- Ulmo, Penguasa Perairan" > cuaca.txt</code></pre>
  </li>
  <li>Melakukan koneksi FTP ke server Eru:
    <pre><code>ftp 192.168.122.114</code></pre>
    Login dengan user <code>ainur</code>.
  </li>
  <li>Mengunggah file dengan perintah:
    <pre><code>put cuaca.txt</code></pre>
  </li>
</ol>

<h3> Analisis dengan Wireshark</h3>
<p>
Selama proses upload, Wireshark menangkap perintah FTP berikut:
</p>
<pre><code>Request: STOR cuaca.txt</code></pre>
<p>
Perintah <code>STOR</code> digunakan oleh protokol FTP untuk mengunggah file dari client ke server.
</p>

<h3> Verifikasi di Server</h3>
<p>
Setelah upload berhasil, file dapat diverifikasi di sisi server dengan:
</p>
<pre><code>ls -l /srv/ftp/sharing/cuaca.txt</code></pre>

<h3> Bukti yang Perlu Diunggah</h3>
<ul>
	<li>Screenshot bukti file cuaca.txt terkirim</li>
	<img width="1450" height="200" alt="image" src="https://github.com/user-attachments/assets/0346da5a-2a35-4811-baa4-81aa151f5f78" />

  <li>Screenshot hasil tangkapan Wireshark yang menunjukkan perintah <code>STOR cuaca.txt</code></li>
  <img width="1664" height="220" alt="image" src="https://github.com/user-attachments/assets/11ccc06b-77b0-4716-8932-a9615bce8ee2" />

  <li>Screenshot dari sisi server Eru yang menampilkan file <code>cuaca.txt</code> di direktori <code>/srv/ftp/sharing</code></li>
  <img width="424" height="92" alt="image" src="https://github.com/user-attachments/assets/eb935efa-6079-4132-8000-54f6c43304f9" />

</ul>

## No. 9

<p>
Eru membagikan file <b>Kitab Penciptaan</b> kepada node <b>Manwe</b> menggunakan protokol FTP. 
User <code>ainur</code> digunakan untuk login ke server dan mengambil file tersebut. 
Setelahnya, akses file diubah menjadi <b>read-only</b> agar user <code>ainur</code> tidak bisa lagi melakukan upload.
</p>

<h3> Langkah-langkah</h3>
<ol>
  <li>Pada server Eru, file <code>kitab_penciptaan.txt</code> dibuat di direktori FTP:
    <pre><code>/srv/ftp/sharing/kitab_penciptaan.txt</code></pre>
  </li>
  <li>Dari node Manwe, dilakukan koneksi ke FTP Server:
    <pre><code>ftp 192.168.122.114</code></pre>
    Login dengan user <code>ainur</code>.
  </li>
  <li>Mengunduh file dengan perintah:
    <pre><code>get kitab_penciptaan.txt</code></pre>
  </li>
</ol>

<h3> Analisis dengan Wireshark</h3>
<p>
Wireshark menangkap perintah FTP berikut ketika file diunduh:
</p>
<pre><code>Request: RETR kitab_penciptaan.txt</code></pre>
<p>
Perintah <code>RETR</code> digunakan oleh protokol FTP untuk mengambil (download) file dari server ke client.
</p>

<h3> Pengujian Hak Akses Read-Only</h3>
<ol>
  <li>Di server Eru, hak akses file diubah menjadi read-only:
    <pre><code>chmod 400 /srv/ftp/sharing/kitab_penciptaan.txt</code></pre>
  </li>
  <li>Dari node Manwe, user <code>ainur</code> mencoba melakukan upload ulang file:
    <pre><code>put kitab_penciptaan.txt</code></pre>
  </li>
  <li>Hasilnya gagal, karena file di server sudah <b>read-only</b>, sehingga user <code>ainur</code> tidak memiliki izin untuk menimpa/menulis file tersebut.</li>
</ol>

<h3> Bukti yang Perlu Diunggah</h3>
<ul>
  <li>Screenshot hasil Wireshark yang menunjukkan perintah <code>RETR kitab_penciptaan.txt</code></li>
  <li>Screenshot isi direktori server (<code>ls -l /srv/ftp/sharing</code>) yang memperlihatkan permission file <code>kitab_penciptaan.txt</code> sudah berubah menjadi <code>-r--------</code></li>
  <li>Screenshot dari sisi Manwe yang menunjukkan kegagalan perintah <code>put kitab_penciptaan.txt</code></li>
</ul>

## No. 10
<p>
Melkor, yang marah karena tidak diberi akses, mencoba melakukan serangan ke node <b>Eru</b> 
dengan mengirimkan banyak request ICMP (ping) dalam jumlah tidak biasa. 
Serangan ini bertujuan untuk membebani server dan menguji kinerjanya.
</p>

<h3> Langkah-langkah</h3>
<ol>
  <li>Dari node Melkor, dijalankan perintah untuk mengirimkan 100 paket ping ke Eru:
    <pre><code>ping -c 100 192.168.122.114</code></pre>
  </li>
  <li>Wireshark diaktifkan untuk menangkap lalu lintas ICMP antara Melkor dan Eru, 
      dengan display filter:
    <pre><code>icmp && ip.addr==10.78.1.1</code></pre>
  </li>
</ol>

<h3> Analisis Hasil</h3>
<p>
Hasil dari perintah ping akan menunjukkan:
</p>
<ul>
  <li><b>Packet loss:</b> apakah ada paket yang hilang selama serangan berlangsung.</li>
  <li><b>Average round-trip time (RTT):</b> nilai rata-rata waktu respon ping, 
      digunakan untuk menilai apakah kinerja server Eru terpengaruh.</li>
</ul>

<p>
Contoh output ringkasan ping:
</p>
<pre><code>
--- 192.168.122.114 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99102ms
rtt min/avg/max/mdev = 0.453/0.600/0.905/0.120 ms
</code></pre>

<h3> Bukti yang Perlu Diunggah</h3>
<ul>
  <li>Screenshot hasil output <code>ping -c 100</code> dari node Melkor (tampilkan packet loss dan average RTT).</li>
  <li>Screenshot hasil capture Wireshark dengan filter <code>icmp && ip.addr==10.78.1.1</code>, 
      yang memperlihatkan banyak request ICMP dikirim ke Eru.</li>
</ul>

## No. 11
<h3> Konfigurasi & Perintah (ringkas)</h3>
<ol>
  <li><b>Di node Melkor (server):</b>
    <pre><code>apt update
apt install vsftpd
adduser eru_test
echo "File uji FTP dari Melkor" &gt; /home/eru_test/penting.txt
chown eru_test:eru_test /home/eru_test/penting.txt

# konfigurasi minimal vsftpd
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
cat &lt;&lt;'EOF' &gt; /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=NO
secure_chroot_dir=/var/run/vsftpd/empty
EOF

mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty
service vsftpd restart
</code></pre>
  </li>

  <li><b>Aktifkan capture Wireshark</b> pada link/interface <code>Melkor &lt;--&gt; Eru</code> sebelum melakukan koneksi client.</li>

  <li><b>Di node Eru (client):</b>
    <pre><code>ftp 10.78.1.2
# saat diminta:
Name: eru_test
Password: &lt;masukkan password eru_test&gt;

ftp&gt; ls
ftp&gt; get penting.txt
ftp&gt; quit
</code></pre>
  </li>
</ol>

<h3> Hasil Capture (contoh)</h3>
<p>Pada Wireshark tercatat paket-paket FTP kontrol yang jelas menunjukkan kredensial:</p>
<pre><code>Frame 6   … 10.78.1.1 → 10.78.1.2   FTP   Request: USER eru_test
Frame 10  … 10.78.1.1 → 10.78.1.2   FTP   Request: PASS eru_test
</code></pre>

<p>Baris di atas menunjukkan bahwa <code>USER</code> dan <code>PASS</code> dikirim sebagai ASCII plaintext dalam payload TCP — sehingga siapa pun yang dapat menangkap trafik pada segmen jaringan tersebut dapat membaca username &amp; password.</p>

<h3>🧾 Bukti yang Harus Diunggah</h3>
<ul>
  <li>Screenshot Wireshark (filter <code>ftp</code>) yang menampilkan baris <code>USER eru_test</code> dan <code>PASS &lt;password&gt;</code>.</li>
  <li>Screenshot <b>Follow TCP Stream</b> untuk koneksi FTP yang menampilkan percakapan lengkap (terlihat <code>USER</code> dan <code>PASS</code> dalam teks jelas).</li>
  <li>Screenshot terminal Melkor yang menunjukkan file uji di home (<code>ls -l /home/eru_test/penting.txt</code>).</li>
  <li>Screenshot terminal Eru yang menunjukkan perintah FTP &amp; berhasil <code>get penting.txt</code>.</li>
</ul>

<h3> Kesimpulan singkat</h3>
<p>
FTP (tanpa TLS) mengirim kredensial autentikasi secara <b>plaintext</b>. Wireshark pada link jaringan bisa menampilkan username &amp; password langsung dari paket TCP.  
Oleh karena itu untuk akses administratif/jarak jauh gunakan protokol terenkripsi (mis. SSH / SFTP atau FTPS) untuk mencegah penyadapan kredensial.
</p>

## No. 12

<h3>🛠️ Konfigurasi & Perintah (Singkat)</h3>
<pre><code># di Melkor (cek & pastikan FTP berjalan)
ss -ltnp | grep :21
service vsftpd restart

# siapkan file uji di Melkor (opsional)
echo "File uji FTP dari Melkor" > /home/eru_test/penting.txt
chown eru_test:eru_test /home/eru_test/penting.txt
ls -l /home/eru_test/penting.txt

# di Eru (siapkan netcat)
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update
apt-get install -y netcat-openbsd

# jalankan pemindaian dari Eru ke Melkor (IP Melkor = 10.78.1.2)
for p in 21 80 666; do
  echo "=== Port $p ==="
  nc -vz -w2 10.78.1.2 $p 2>&1
done | tee /tmp/scan_result.txt
</code></pre>

<h3> Hasil Pemindaian (output)</h3>
<pre><code>=== Port 21 ===
Connection to 10.78.1.2 21 port [tcp/ftp] succeeded!
=== Port 80 ===
nc: connect to 10.78.1.2 port 80 (tcp) failed: Connection refused
=== Port 666 ===
nc: connect to 10.78.1.2 port 666 (tcp) failed: Connection refused
</code></pre>

<h3> Analisis & Interpretasi</h3>
<ul>
  <li><b>Port 21 — OPEN</b>  
    Hasil <code>Connection ... succeeded!</code> menunjukkan <b>vsftpd</b> di Melkor mendengarkan pada port 21. Di Wireshark akan tampak 3-way handshake: <code>SYN → SYN/ACK → ACK</code>.</li>

  <li><b>Port 80 — CLOSED</b>  
    Hasil <code>Connection refused</code> menunjukkan Melkor mengembalikan <code>RST</code> untuk permintaan koneksi ke port 80. Ini menandakan <b>tidak ada listener</b> pada port 80 (server menolak koneksi), bukan filtering.</li>

  <li><b>Port 666 — CLOSED</b>  
    Sama seperti port 80, Melkor mengembalikan <code>RST</code> — artinya port 666 tidak ada layanan (tertutup).</li>
</ul>

<p>
Catatan: <b>Connection refused (RST)</b> berbeda dari <b>timeout</b>. Jika tidak ada balasan sama sekali (timeout), kemungkinan paket dibuang/filtered. Dalam kasus ini, Melkor memang menolak koneksi secara eksplisit.
</p>

<h3> Wireshark — filter & bukti yang diambil</h3>
<p>Gunakan capture pada link Eru ↔ Melkor dan pakai display filter:</p>
<pre><code>tcp && ip.addr==10.78.1.2</code></pre>
<p>Bukti Wireshark yang direkomendasikan:</p>
<ul>
  <li>Untuk <b>port 21</b>: screenshot paket yang menunjukkan <code>SYN</code> (Eru → Melkor), <code>SYN, ACK</code> (Melkor → Eru), dan <code>ACK</code> (Eru → Melkor) — bukti 3-way handshake.</li>
  <li>Untuk <b>port 80</b> dan <b>666</b>: screenshot paket yang menunjukkan <code>SYN</code> diikuti oleh <code>RST</code> (atau <code>RST, ACK</code>) dari Melkor — bukti port tertutup.</li>
  <li>Screenshot output hasil scan (`/tmp/scan_result.txt`) yang menunjukkan teks hasil `nc`.</li>
</ul>

<h3> Bukti yang Perlu Diunggah ke Repo</h3>
<ol>
  <li>Output scan (`/tmp/scan_result.txt`) atau capture terminal yang menunjukkan hasil netcat.</li>
  <li>Screenshot Wireshark: 3-way handshake untuk port 21 (SYN / SYN-ACK / ACK).</li>
  <li>Screenshot Wireshark: SYN → RST untuk port 80 dan 666 (bukti closed).</li>
  <li>Optional: output <code>ss -ltnp | grep :21</code> di Melkor sebagai bukti listener vsftpd.</li>
</ol>

<h3>🔚 Kesimpulan singkat</h3>
<p>
Pemindaian sederhana menunjukkan bahwa <b>Melkor menjalankan layanan FTP di port 21</b> sementara <b>port 80 dan 666 tertutup</b>. Karena balasan berupa <code>RST</code>, tidak ditemukan indikasi filtering; Melkor memang tidak menjalankan layanan pada port yang diuji (80, 666).
</p>

## No. 13
<h2> Laporan: Demonstrasi Keamanan SSH (Varda → Eru)</h2>

<p>
Tujuan: Menunjukkan bahwa koneksi administratif melalui <b>SSH</b> (Secure Shell) mengenkripsi komunikasi sehingga <b>username</b> dan <b>password</b> tidak dapat disadap sebagai plaintext. Eksperimen dilakukan di lingkungan lab (GNS3) menggunakan <b>OpenSSH</b> pada node <b>Eru</b> dan <b>Wireshark</b> untuk capture.
</p>

<h3>🛠️ Persiapan & Perintah</h3>
<ol>
  <li><b>Di node Eru (server):</b>
    <pre><code>apt-get update
apt-get install -y openssh-server

# cek IP Eru
ip a

# restart & cek service ssh
service ssh restart
service ssh status
ss -ltnp | grep :22

# (opsional) buat user admin
adduser admin_erux
# isi password, mis: adminpass
</code></pre>
  </li>

  <li><b>Di node Varda (client):</b>
    <pre><code># lakukan koneksi SSH ke Eru
ssh admin_erux@&lt;IP_ERU&gt;

# contoh interaksi (setelah login)
whoami
uptime
ls -la ~
exit
</code></pre>
  </li>

  <li><b>Capture Wireshark:</b> Start capture pada link/interface <b>Varda ↔ Eru</b> sebelum menjalankan perintah <code>ssh</code>. Gunakan display filter:
    <pre><code>tcp.port == 22
# atau
ssh
</code></pre>
  </li>
</ol>

<h3> Analisis / Apa yang Terlihat di Wireshark</h3>
<ul>
  <li><b>Handshake TCP</b> (SYN / SYN-ACK / ACK) — transport layer normal.</li>
  <li><b>Banner awal</b> (plaintext): paket yang berisi <code>SSH-2.0-OpenSSH_...</code> — hanya header protokol.</li>
  <li><b>Key Exchange (KEX)</b>: beberapa paket negosiasi algoritma dan pertukaran parameter (mis. Diffie–Hellman).</li>
  <li><b>Encrypted packets</b> setelah KEX: hampir semua payload tampil sebagai <em>Encrypted packet</em> atau biner — isi (termasuk username/password saat autentikasi) tidak dapat dibaca di Wireshark.</li>
</ul>

<p>
<strong>Kesimpulan teknis singkat:</strong> SSH melakukan key exchange untuk membentuk session key bersama, lalu semua data (termasuk kredensial) dienkripsi menggunakan cipher simetris. Karena itu username/password <em>tidak pernah</em> lewat jaringan sebagai teks jelas.
</p>

<h3> Bukti yang Harus Diunggah</h3>
<ul>
  <li>Screenshot Wireshark: paket banner &amp; Key Exchange (filter = <code>tcp.port==22</code> / <code>ssh</code>).</li>
  <li>Screenshot Wireshark: paket berlabel <code>Encrypted packet</code> (tunjukkan panel Packet Bytes yang menampilkan data biner, bukan ASCII readable).</li>
  <li>Screenshot Follow → TCP Stream pada sesi SSH (menampilkan data acak/biner — bukti terenkripsi).</li>
  <li>Screenshot terminal Varda yang menunjukkan perintah <code>ssh admin_erux@&lt;IP_ERU&gt;</code> dan prompt password (opsional: gunakan <code>ssh -v</code> untuk menampilkan proses handshake di client).</li>
  <li>Sekaligus unggah satu screenshot perbandingan: Follow TCP Stream untuk sesi FTP/Telnet (menunjukkan <code>USER</code>/<code>PASS</code> plaintext) vs Follow TCP Stream sesi SSH (terenkripsi).</li>
</ul>

## No. 14
Pada soal ini, kita akan mencari berapa banyak paket dalam file `.pcapng`. Untuk mencarinya kita hanya perlu melihat bagian bawah dari Wireshark. Untuk tampilannya seperti ini.

<img width="142" height="50" alt="Screenshot 2025-10-04 at 10 24 44" src="https://github.com/user-attachments/assets/a91ec772-41c8-4992-98ee-d8ac09b6f015" />

Selanjutnya, kita akan mencari username dan password yang berhasil login menggunakan `http.response.code==200 && !(http contains"Invalid")`.

<img width="1141" height="153" alt="Screenshot 2025-10-04 at 13 00 36" src="https://github.com/user-attachments/assets/60888094-2037-4ead-819b-af451a201577" />

Setelah itu, kita follow TCP untuk mendapatkan informasi username dan password. 

<img width="981" height="531" alt="Screenshot 2025-10-04 at 13 02 21" src="https://github.com/user-attachments/assets/ff6b3bdc-a95b-49e2-ae94-95b78411fc69" />

Dari gambar tersebut, ada informasi stream di bawah kanan dan tools yang digunakan untuk brute force. Setelah kita dapatkan datanya, kita langsung saja masukkan ke `nc 10.15.43.32 3401`. Setelah kita memasukkan datanya ke sana, kita mendapatkan sebuah flag.

<img width="865" height="434" alt="Screenshot 2025-10-04 at 13 31 28" src="https://github.com/user-attachments/assets/542af136-2e04-47a2-8253-8d2b11c27f7b" />

## No. 16
Pada soal ini, kita akan mencari username dan password yang ada pada file pcap.
<img width="1470" height="859" alt="Screenshot 2025-10-04 at 07 44 18" src="https://github.com/user-attachments/assets/1e496a5c-8491-4219-8631-9b3b699b626a" />

Lalu, kita akan mencari file-file yang ada di dalamnya. Jika dilihat dari hasil follow TCPnya, kita dapat menemukan lima file.

![Desain tanpa judul_2](https://github.com/user-attachments/assets/02b5bfa4-8bb5-4c7c-8ac6-aa9bee7586a0)

Setelah itu, kita akan mencari sha256 dari 5 file. Kita menggunakan q.exe di sini menggunakan fitur find di Wireshark.

<img width="1419" height="302" alt="Screenshot 2025-10-04 at 07 54 57" src="https://github.com/user-attachments/assets/0feec6b3-0c6e-4fb8-9124-c7fea509eba4" />

Setelah itu, kita follow TCP stream, lalu ubah tampilan datanya menjadi `RAW`. Setelah itu kita save as `.exe`.

<img width="1409" height="529" alt="Screenshot 2025-10-04 at 07 58 08" src="https://github.com/user-attachments/assets/cb6bf51d-8a99-4dd0-a089-ed4fa6137c6e" />

Kita buka terminal, lalu kita command `sha256 <namafile>`. Untuk hasilnya seperti ini.

<img width="1397" height="388" alt="Screenshot 2025-10-04 at 08 00 02" src="https://github.com/user-attachments/assets/6eddc8e8-c284-4412-9707-1a1a499321b0" />

Setelah semua datanya kita dapatkan, kita masukkan ke `nc 10.15.43.32 3403`. Untuk hasilnya seperti ini.

<img width="969" height="713" alt="Screenshot 2025-10-04 at 08 00 57" src="https://github.com/user-attachments/assets/67c368d9-3049-4ac5-b12e-7eead395486d" />

## No. 18
Pada soal ini, kita akan mencari berapa file yang mengandung malware, dan ditemukan ada dua file.

![Wireshark19_1](https://github.com/user-attachments/assets/795794bd-0d57-4abe-9356-d091ecf5b478)

Setelah itu, kita follow TCPnya, lalu kita find dengan kata kunci `.exe`.

<img width="714" height="294" alt="Screenshot 2025-10-03 at 12 50 48" src="https://github.com/user-attachments/assets/848d1ac3-8ac8-440e-99fb-58452c7ffacc" />

<img width="713" height="293" alt="Screenshot 2025-10-03 at 12 51 30" src="https://github.com/user-attachments/assets/4b2445bb-e402-44fa-a783-e77c04cde480" />

Lalu, kita akan mencari sha256 dari masing-masing file. Caranya yaitu dengna melakukan `File -> Export Objects -> SMB`, lalu muncul tampilan seperti di bawah, lalu save sebagai file exe.

<img width="838" height="554" alt="Screenshot 2025-10-03 at 13 31 43" src="https://github.com/user-attachments/assets/0337f759-f952-4d21-a20c-25d9278b79e4" />

Setelah itu, kita coba cari code sha256 melalui terminal. Untuk command dan hasilnya seperti ini.
<img width="1435" height="185" alt="Screenshot 2025-10-03 at 13 33 38" src="https://github.com/user-attachments/assets/2b993954-aede-436c-944b-cbfec2fa2750" />

Lalu kita masukkan ke `nc 10.15.43.32 3405` sehingga mendapatkan flag. Untuk hasilnya seperti ini.

<img width="1251" height="718" alt="Screenshot 2025-10-03 at 13 35 28" src="https://github.com/user-attachments/assets/0d2c405d-d05d-4be7-a384-c44e01761bea" />


## No. 19 

pada soal ini, kita akan mencari user yang menyerang. 

Caranya dengan menggunakan fitur search di Wiresharl (shortcut: `cmd + f` atau `ctrl + f`) lalu ketik "user". Setelah itu kita melakukan follow TCP untuk emngetahui detailnya. Untuk hasilnya seperti pada gambar di bawah.
<img width="1089" height="157" alt="Image" src="https://github.com/user-attachments/assets/8d895124-f711-4009-a1b4-076e0cf7c45e" />

<img width="714" height="491" alt="Screenshot 2025-10-03 at 12 34 05" src="https://github.com/user-attachments/assets/8393fa1e-c2ee-4e48-aba8-901eeb78689a" />
<img width="716" height="490" alt="Screenshot 2025-10-03 at 12 39 17" src="https://github.com/user-attachments/assets/12f8da6c-0b41-4172-a555-91670038f7f5" />


Dari sini kita dapat usernya, yaitu `Your Life`. Setelah datanya kita dapatkan kita masukkan ke `nc 10.15.43.32 3406`. Selanjutnya, kita input data yang ada di screenshot tersebut hingga kita dapat menemukan sebuah flag. Untuk hasilnya seperti ini.
<img width="1437" height="762" alt="Screenshot 2025-10-03 at 12 37 31" src="https://github.com/user-attachments/assets/5cebb95d-a75a-45b7-b123-8f62e9d06bb7" />
