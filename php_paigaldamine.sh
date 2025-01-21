#!/bin/bash

# Kontrollime kas PHP on installitud
if dpkg -l | grep -qw php; then
#Kui on ütleme kasutajale, et on installitud, näitame kausta ja versiooni.
        echo "PHP on juba installitud."
        which php
	php -v
else
#Kui ei ole installitud paigaldame PHP, näiteme kausta ja versiooni.
        echo "Paigaldame PHP ja vajalikud lisad"
        apt install php php-mysql libapache2-mod-php
        echo "PHP on paigaldatud"
	which php
	php -v
fi
