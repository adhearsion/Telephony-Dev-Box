1. Install virtualbox
2. Install vagrant (http://vagrantup.com/downloads)
3. Add the lucid32 base box (`vagrant box add precise64 http://files.vagrantup.com/precise64.box`)
4. Boot all VMs (`vagrant up`) or just the desired VM (eg `vagrant up asterisk`)
5. (optional) To package the boxes (while they are running) type `rake package` (this will preserve port mapping and create a minimal package)
