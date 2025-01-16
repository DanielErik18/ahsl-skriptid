#!/bin/bash

# Kontrollime kas apache2 teenus on installitud
if dpkg -l | grep -qw apache2; then
#Kui on ütleme kasutajale, et on installitud, paneme käima ja näitame statust.
	echo "Apache2 on juba installitud."
	systemctl start apache2
	systemctl status apache2
else
#Kui ei ole installitud paigaldame apache2 teenuse, paneme käima ja näitame statust.
	echo "Paigaldame apache2"
	apt install apache2
	echo "Apache on paigaldatud"
	systemctl start apache2
	systemctl status apache2
fi
