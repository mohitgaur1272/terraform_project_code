#!/bin/bash
sudo -i
apt update
apt install apache2 -y 
echo "this is first web server" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2
