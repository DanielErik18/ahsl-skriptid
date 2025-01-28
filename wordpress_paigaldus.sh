#!/bin/bash

#Skripti tuleb jooksutada root kasutajana, kasuta käsku su -

#MYSQL edukaks installiks peaks eelnevalt tegema commandid, kui teete ise peate panema ette ###

wget https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
apt install gnupg -y
dpkg -i mysql-apt-config_0.8.20-1_all.deb

apt-key del A4A9 4068 76FC BD3C 4567  70C8 8C71 8D3B 5072 E1F5
apt-key adv --keyserver pgp.mit.edu --recv-keys B7B3B788A8D3785C

apt update
apt upgrade


#Funktsioon teenuste kontrollimiseks ja vajadusel installimiseks.
kontroll(){
	local service=$1
	local package=$2

	echo "Kontrollin, kas teenus $service on paigaldatud ja töötab."
	#Kontrollime, kas teenus on paigaldatud
	if ! dpkg-query -l | grep -q $package;then
		echo "$service ei ole paigaldatud. Paigaldan $package."
		apt-get install -y $package
	else
		echo "$service on paigaldatud."
	fi

	#Kontrollime, kas teenus on käimas
	if ! systemctl is-active --quiet $service;then
		echo "$service ei ole tööle pandud, käivitame teenuse."
		systemctl start $service
		systemctl enable $service
	else
		echo "$service on juba töökorras."
	fi
}


kontroll apache2 apache2
kontroll mysql mysql-server

#PHP paigalduse kontroll.

echo "Kontrollime, kas PHP on paigaldatud."
if ! php -v > /dev/null 2>&1;then
	echo "PHP ei ole paigaldatud, paigaldame."
	apt-get install -y php libapache2-mod-php php-mysql
else
	echo "PHP on paigaldatud."
fi

#mysql andmebaasi loomine.
DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASS="qwerty"

mysql --user='root' --password="qwerty" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql --user='root' --password="qwerty" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql --user='root' --password="qwerty" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql --user='root' --password="qwerty" -e "FLUSH PRIVILEGES;"

#Wordpressi install
cd /var/www/html
if [ ! -d "wordpress" ]; then
	echo "Laadin alla WordPressi..."
	wget https://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz
	chown -R www-data:www-data wordpress
else
    echo "WordPress on juba allalaaditud."
fi

#WordPressi wp-config.php faili konfigureerimine.
cd /var/www/html/wordpress
if [ ! -f "wp-config.php" ]; then
	echo "Kopeerin wp-config-sample.php ja kohandan selle..."
	cp wp-config-sample.php wp-config.php

	# Asendame andmebaasi nime, kasutaja ja parooli wp-config.php failis
	sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
	sed -i "s/username_here/$DB_USER/g" wp-config.php
	sed -i "s/password_here/$DB_PASS/g" wp-config.php

	chown www-data:www-data wp-config.php
else
	echo "wp-config.php on juba olemas."
fi

echo "Kontrollige, kas WordPress töötab veebibrauserist."
