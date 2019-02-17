#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo PHP AND EXTENSIONS
echo -----------------------------------------------------------------------------------------------

# define parameters
export version="7.2"
export web_dir="/var/www"
export conf_dir="/etc/php/$version"

# define packages
packages=( \
    php-cli \
    php-fpm \
    php-mysql 
)

# install related packages
echo ">> installing packages.."
sudo -E apt-get -qq install ${packages[@]}

# copy custom php configurations
echo '>> copying custom php configurations'
sudo cp $provision_dir/php/0-cli.ini /$conf_dir/cli/conf.d/.
sudo cp $provision_dir/php/0-fpm.ini /$conf_dir/fpm/conf.d/.

# create php-info page to be used in index
echo ">> copying index.php file in $web_dir .."
sudo cp $provision_dir/php/index.php $web_dir/.

# restart service
echo '>> restarting service..'
sudo service php$version-fpm restart