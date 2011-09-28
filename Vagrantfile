Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box       = "lucid32"
  config.vm.host_name = "mojolingo-dev.local"

  # Bump the memory to accommodate PRISM
  config.vm.customize do |vm|
    vm.memory_size = 512
    vm.name        = "Mojo Lingo Telephony App Development"
  end

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port "prism", 8080, 18080

  config.vm.network "192.168.10.10"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "vagrant_main"

    # You may also specify custom JSON attributes:
    chef.json = { :mysql_password => "foo" }
  end

  # Set the name for the packaged VM file
  config.package.name = 'mojolingo_dev.box'

end
