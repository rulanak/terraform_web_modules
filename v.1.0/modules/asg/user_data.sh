#!/bin/bash
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo echo "Hello from ${env} Instance" >> /var/www/html/index.html