#! /bin/bash

sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Welcome Folks, You have deployed Apache using terraform </h1>" | sudo tee /var/www/html/index.html
