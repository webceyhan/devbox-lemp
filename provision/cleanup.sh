#!/usr/bin/env bash


echo -----------------------------------------------------------------------------------------------
echo CLEANUP SYSTEM
echo -----------------------------------------------------------------------------------------------

# define packages to remove
packages=( \
    chef ^chef-* \
    puppet ^puppet-* \
	linux-headers-$(uname -r) \
)

# remove unused packages
echo ">> uninstalling unused packages.."
sudo apt-get -qq purge "${packages[@]}"
sudo apt-get -qq autoremove

# remove leftover leases and persistent rules
echo ">> cleaning up dhcp leases"
sudo rm -f /var/lib/dhcp/*

# make log files empty
echo ">> emptying log files"
sudo find /var/log -type f | while read log; do
    echo -ne '' | sudo tee $log
done

# clear history files of current usere
echo ">> clearing history files"
unset HISTFILE && history -c
rm -f ~/.bash_history

# fill all free hdd space with zeros
echo ">> removing blank disk spaces"
sudo dd if=/dev/zero of=/EMPTY bs=1M &> /dev/null
sudo rm -f /EMPTY
