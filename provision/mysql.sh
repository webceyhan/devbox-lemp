#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo MYSQL DATABASE SERVER
echo -----------------------------------------------------------------------------------------------

# define parameters
export db_user='root'
export db_pass='root'
export config_file='/etc/mysql/my.cnf'

# set username and password to 'root' for unattended installation
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $db_pass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $db_pass"

# install mysql
echo ">> installing mysql.."
sudo -E apt-get -qq install mysql-server

# adding grant privileges to mysql root user from everywhere
echo '>> granting all permissions globally to root on all hosts'
sql="GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;"
mysql -u$db_user -p$db_pass -e "$sql" &> /dev/null # grant and flush privileges
mysql -u$db_user -p$db_pass -e "FLUSH PRIVILEGES;" &> /dev/null

# # turn on query logging
# echo ">> enabling query logging .."
# sudo sed -Ei 's|^#(general_log_file.*)|\1|' $config_file
# sudo sed -Ei 's|^#(general_log.*)|\1|' $config_file 

# restart service
echo '>> restarting service..'
sudo service mysql restart
