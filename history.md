579  cd shared/
580  mkdir zoo
581  cd zoo
582  cat > "Домашние животные"
583  cat > "Вьючные животные"
584  cat "Домашние животные" "Вьючные животные" > Animals
585  cat Animals
586  mv Animals mans_friends
587  ll
588  mkdir zoo_System
589  mv mans_friends zoo_System
590  sudo apt-get update
591  sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.23-1_all.deb
592  sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb
593  sudo apt-get update
594  sudo apt-get install mysql-server
595  sudo wget http://ftp.us.debian.org/debian/pool/main/s/sl/sl_5.02-1_amd64.deb
596  sudo dpkg -i sl_5.02-1_amd64.deb
597  sudo dpkg -r sl
598  history