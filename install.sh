#!/bin/bash
sudo apt update 
sudo apt install apache2 -y 
sudo systemctl start apache2
sudo systemctl enable apache2 
echo "<h1>Welcome to Mohit's Terraform EC2</h1>" > /var/www/html/index.html
