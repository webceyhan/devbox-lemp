#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo BASEBOX OPTIMIZATIONS
echo -----------------------------------------------------------------------------------------------

# define packages to install
packages=( \
    git \
    curl \
    unzip \
    gettext
)

# set machine hostname
echo ">> changing hostname to $box_host"
echo $box_host | sudo tee /etc/hostname > /dev/null

# set machine timezone
echo ">> setting timezone to $box_timezone"
sudo ln -sf /usr/share/zoneinfo/$box_timezone /etc/localtime

# set machine locale
echo ">> setting locale to $box_locale"
sudo locale-gen "$box_locale" 1> /dev/null
sudo dpkg-reconfigure -f noninteractive locales 1> /dev/null

# apply user profile optimizations
echo ">> patching global bashrc file"
cat $provision_dir/base/bash.bashrc | sudo tee -a /etc/bash.bashrc > /dev/null

# enable case insensitive tab completions
echo ">> enabling case insensitive tab completions .."
cp $provision_dir/base/inputrc ~/.inputrc

# update apt-get repositories
echo ">> updating package repositories.."
sudo apt-get update 1> /dev/null
sudo apt-get -qq dist-upgrade

# install additional packages
echo ">> installing additional packages.."
sudo -E apt-get -qq install "${packages[@]}"
