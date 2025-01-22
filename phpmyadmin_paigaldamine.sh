#!/bin/bash

# Kontrollime kas phpmyadmin on installitud
if dpkg -l | grep -qw phpmyadmin; then
#Kui on ütleme kasutajale, et on installitud, näitame kausta ja versiooni.
        echo "phpmyadmin on juba installitud."
else
#Kui ei ole installitud paigaldame phpmyadmini, näiteme kausta ja versiooni.
        echo "Paigaldame phpmyadmini ja vajalikud lisad"
        apt install phpmyadmin
        echo "PHP on paigaldatud"
fi
