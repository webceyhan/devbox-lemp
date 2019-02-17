# this file creates a new virtual machine and executes selected
# provisioners to be compiled as preconfigured vagrant box.
Vagrant.configure(2) do |config|

  # set basebox to be imported
  config.vm.box = "ubuntu/bionic64"

  # enable automatic box update before building
  config.vm.box_check_update = false

  # disable automatic ssh-key generation
  config.ssh.insert_key = false

  # set default vm hostname
  config.vm.hostname = "devbox"

  # create host-only private network specifying ip address
  # and enable auto-config to inject static configuration into /etc/network
  config.vm.network "private_network", ip: "192.168.33.10", auto_config: true

  # fine-tune virtualbox specific configurations
  config.vm.provider "virtualbox" do |vb|
      vb.gui = false   # display GUI on boot
      vb.cpus = 1      # cpu core numbers
      vb.memory = 2048 # amount of memory (2Gb)
  end

  # enable guest-tools pluging (required)
  config.vbguest.auto_update = true
  

  #############################################################################
  # Shell Provisioners
  #############################################################################

  # bugfix: mesg is not tty when connection via ssh
  config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/^mesg n$/tty -s \\&\\& mesg n/' /root/.profile
  SHELL

  # run shell installer to apply selected provisioners
  config.vm.provision "shell", 
  path: "provision/main", 
  privileged: false

end
