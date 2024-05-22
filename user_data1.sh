#!/bin/bash
sudo -i
apt update
apt install apache2 -y 
echo "this is first web server" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2

####################################################################################################
#install prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.51.0-rc.0/prometheus-2.51.0-rc.0.linux-amd64.tar.gz
tar xvzf prometheus-2.51.0-rc.0.linux-amd64.tar.gz
cd  prometheus-2.51.0-rc.0.linux-amd64

#if you are use this tool in industry so follow given steps
#move promtool and prometheus in /usr/local/bin/ folder for make executable any where in terminal
mkdir /var/local/bin 
mv promtool /var/local/bin/promtool
mv prometheus /usr/local/bin/

#now create prometheus user and group for run this service by only this user
groupadd prometheus
useradd -s /bin/bash -g prometheus prometheus 

#now create folder for save data of server metrix and move console_libraries consoles prometheus.yml this  /etc/prometheus/ location 
mkdir /var/lib/prometheus
mkdir /etc/prometheus
mv console_libraries consoles prometheus.yml /etc/prometheus/

#give permission prometheus user and group of /etc/prometheus folder
chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus
chown -R prometheus:prometheus /usr/local/bin/
chown -R prometheus:prometheus /var/local/bin/promtool

#now if you want to start and enable by "systemctl" command prometheus like docker and apache2 so you have to do create
#file in systemd folder so run this command

bash -c 'cat > /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Restart=on-failure

# Location of the prometheus executable
ExecStart=/usr/local/bin/prometheus \\
  --config.file=/etc/prometheus/prometheus.yml \\
  --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
EOF'

#now run this commnad for undestand to system-daemon that i have added one more service so run this
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
