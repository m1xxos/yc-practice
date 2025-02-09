#!/bin/bash
apt-get update -q
apt-get install -y -q nginx
sed -i -- "s/Welcome to nginx/Welcome to the first test!/" /var/www/html/index.nginx-debian.html
systemctl enable nginx --now