1. Get submodules (`git submodule init && git submodule update`)
2. Install virtualbox
3. Install vagrant (http://vagrantup.com/downloads)
4. Add the required base boxes
  `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
  `vagrant box add centos63_64min https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box`
5. Boot all VMs (`vagrant up`) or just the desired VM (eg `vagrant up asterisk`)
6. (optional) To package the boxes (while they are running) type `rake package` (this will preserve port mapping and create a minimal package)
