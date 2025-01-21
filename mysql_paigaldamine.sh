#!/bin/bash

# Eeltöö mysql installimiseks
# wget https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
# apt install gnupg -y
# dpkg -i mysql-apt-config_0.8.20-1_all.deb
# Juhendis oli vanem versioon mis, ei töötanud

# apt update
# Tuli key error
# apt-key del A4A9 4068 76FC BD3C 4567  70C8 8C71 8D3B 5072 E1F5
# apt-key adv --keyserver pgp.mit.edu --recv-keys B7B3B788A8D3785C

# apt update
# apt upgrade

# Kontrollime kas mysql on installitud
if dpkg -l | grep -qw mysql-server; then
#Kui on ütleme kasutajale, et on installitutud ja paneme käima.
        echo "mysql-server on juba paigaldatud"
        mysql
else
#Kui ei ole installitud paigaldame mysql.
        echo "Paigaldame mysql ja vajalikud lisad"
        apt install mysql-server
	touch $HOME/.my.cnf
	echo "[client]" >> $HOME/.my.cnf
	echo "host" = localhost >> $HOME/.my.cnf
	echo "user" = root >> $HOME/.my.cnf
	echo "password" = qwerty >> $HOME/.my.cnf

fi
