Vagrant::Config.run do |config|
  config.vm.box       = "lucid32"
  config.vm.host_name = "mojolingo-dev.local"

  # Bump the memory to accommodate PRISM
  config.vm.customize do |vm|
    vm.memory_size = 512
    vm.name        = "Mojo Lingo Telephony App Development"
  end

  config.vm.network :hostonly, "192.168.10.10"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.add_recipe "apt"
    chef.add_recipe "prism"
    chef.add_recipe "rayo"
    chef.add_recipe "prism_upstart"
    chef.add_recipe "asterisk"
    chef.add_recipe "motd-tail"

    chef.json = { :mysql_password => "foo" }

    chef.log_level = :debug
  end

  config.package.name = 'mojolingo_dev.box'
end
