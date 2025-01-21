#!/bin/bash

# Kontrollime kas apache2 teenus on installitud
if dpkg -l | grep -qw php; then
#Kui on ütleme kasutajale, et on installitud, paneme käima ja näitame statust.
        echo "PHP on juba installitud."
        which php
	php -v
else
#Kui ei ole installitud paigaldame apache2 teenuse, paneme käima ja näitame statust.
        echo "Paigaldame PHP ja vajalikud lisad"
        apt install php php-mysql libapache2-mod-php
        echo "PHP on paigaldatud"
	which php
	php -v
fi
