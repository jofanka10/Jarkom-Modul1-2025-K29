# di node enu :
root@Eru:~# echo "Sebelum Awal, Akulah Ada.
Dari Pikiran-Ku yang tunggal,
Lahir Kehendak untuk Mencipta,
Dan Hampa pun mendengar.

Maka Kuciptakan para Ainur, Anak-anak dari Pikiran-Ku.
Masing-masing adalah percikan dari Nyala Api Abadi,
Membawa sebagian dari esensi-Ku, namun tidak seluruhnya.

Kuberikan kepada mereka sebuah Tema Agung,
Dan kuminta mereka merajutnya menjadi Musik yang tiada tara.
Dalam Harmoni mereka, sebuah Visi terbentang:
Dunia yang akan ada, Arda.

Namun satu di antara mereka, yang terkuat, menenun melodi sumbang dari kesombongan.
Tetapi dia tidak tahu, bahwa nada paling gelap sekalipun
Pada akhirnya hanya akan menjadi bagian dari Desain-Ku yang lebih agung.

Maka saat Visi itu utuh, Aku pun bersabda:
Dan Dunia pun menjadi nyata, terikat dalam Ruang dan Waktu.

Di sanalah, Anak-anak Il\303\272vatar akan berjalan,
Dan melalui mereka, takdir Dunia akan digenapi.
Sebab segala sesuatu berasal dari-Ku, dan akan kembali kepada-Ku.
" > /srv/ftp/sharing/kitab_penciptaan.txt

# Login ke FTP server dari Manwe:
ftp 192.168.122.114
login ainu

# nyalakan wireshark
get kitab_penciptaan.txt

chmod 400 /srv/ftp/sharing/penting.txt # (set file read only)

put kitab_penciptaan.txt # (uji lagi)

