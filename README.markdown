1. Get submodules (`git submodule init && git submodule update`)
2. Install virtualbox
3. Install vagrant (http://vagrantup.com/downloads)
4. Add the precise64 base box (`vagrant box add precise64 http://files.vagrantup.com/precise64.box`)
5. Boot all VMs (`vagrant up`) or just the desired VM (eg `vagrant up asterisk`)
6.(optional) To package the boxes (while they are running) type `rake package` (this will preserve port mapping and create a minimal package)
