#!/bin/bash
sudo -i
apt update
apt install apache2 -y 
echo "this is second web server" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2

#####################################################################################
#Go official document install grafana or got this link
#then run command for Ubuntu and Debian(64 Bit)
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.0.0_amd64.deb
sudo dpkg -i grafana-enterprise_11.0.0_amd64.deb


/bin/systemctl daemon-reload
/bin/systemctl enable grafana-server
/bin/systemctl start grafana-server
/bin/systemctl status grafana-server
