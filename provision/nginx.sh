#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo NGINX WEB SERVER
echo -----------------------------------------------------------------------------------------------

# define parameters
export web_dir="/var/www"
export conf_dir="/etc/nginx"
export vhost_dir="$conf_dir/sites-available"

# install nginx and related packages
echo ">> installing nginx and related packages.."
sudo -E apt-get -qq install nginx

# override default configuration
echo ">> overriding /etc/nginx/nginx.conf"
sudo cp -f $provision_dir/nginx/nginx.conf $conf_dir/.

# override default virtual host
echo ">> overriding /etc/nginx/sites-available/default"
sudo cp -f $provision_dir/nginx/default $vhost_dir/.

# remove /var/www/html folder
echo ">> remove /var/www/html folder"
sudo rm -rf $web_dir/html

# restart service
echo '>> restarting service..'
sudo service nginx restart
