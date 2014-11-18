#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y apache2 php5 libapache2-mod-php5 libapache2-svn php5-sqlite subversion
sudo a2enmod rewrite
sudo a2enmod dav
sudo a2enmod dav_fs
sudo a2enmod authz_svn
sudo a2enmod dav_svn

# Download and move USVN
cd ~
mkdir usvntmp && cd usvntmp
wget -q https://github.com/usvn/usvn/archive/1.0.7.tar.gz
tar xvfz 1.0.7.tar.gz
rm 1.0.7.tar.gz
mv usvn-1.0.7 usvn
sudo mv usvn /var/usvn

# USVN Bugfix
sudo sudo sed -i '72s/.*/\texit(0);/' /var/usvn/app/bootstrap.php

# Folders and permissions
cd /var
sudo chown -R www-data:www-data usvn
cd usvn
sudo mkdir files
sudo chown -R www-data:www-data files
sudo chmod -R 777 files

# Copy Apache host config
sudo rm /etc/apache2/sites-available/default
sudo cp /vagrant/apache-default /etc/apache2/sites-available/default

# Restart Apache service
sudo service apache2 restart
