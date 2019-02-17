#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo COMPOSER
echo -----------------------------------------------------------------------------------------------

# download composer and installing
echo '>> downloading composer installer ..'
curl -sS 'https://getcomposer.org/installer' | php &> /dev/null
sudo mv composer.phar /usr/local/bin/composer # move to bin folder

# print version and status
expr='(?<=version )(.*)(?= \(.*)'
version=$(composer --version | grep -Po "$expr")
echo ">> composer installed....$version"

# ensure COMPOSER_HOME variable is set. This isn't set by Composer automatically
# then add composer home vendor bin dir to PATH to run globally installed executables    
echo -e '\nCOMPOSER_HOME="/home/vagrant/.composer"\n' >> /home/vagrant/.profile
echo -e '\nPATH="$PATH:$COMPOSER_HOME/vendor/bin"\n' >> /home/vagrant/.profile

# and source the .profile to pick up changes
source /home/vagrant/.profile
