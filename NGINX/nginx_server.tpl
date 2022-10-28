#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo ufw allow 443/tcp
sudo systemctl enable nginx
sudo systemctl start nginx