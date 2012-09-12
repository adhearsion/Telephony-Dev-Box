Vagrant::Config.run do |config|
  config.vm.box       = "lucid32"
  config.vm.host_name = "mojolingo-dev.local"

  # Bump the memory to accommodate PRISM
  config.vm.customize do |vm|
    vm.memory_size = 512
    vm.name        = "Mojo Lingo Telephony App Development"
  end

  config.vm.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

  config.vm.network :hostonly, "192.168.10.10"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    chef.add_recipe "apt"
    chef.add_recipe "motd-tail"
    chef.add_recipe "prism"
    chef.add_recipe "rayo"
    chef.add_recipe "prism_upstart"
    chef.add_recipe "asterisk"
    chef.add_recipe "freeswitch"
    chef.add_recipe "java"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"

    chef.json = {
      asterisk: {
        manager_ip_address: '192.168.10.10',
        manager_permit: '0.0.0.0/0.0.0.0',
        manager_read_perms: %w{all},
        manager_write_perms: %w{all}
      },
      'rbenv' => {
        'user_installs' => [
          { 'user'    => 'vagrant',
            'rubies'  => ['1.9.3-p194', 'jruby-1.6.7.2'],
            'global'  => '1.9.3-p194',
            'gems'    => {
              '1.9.3-p194' => [
                { 'name' => 'bundler' },
                { 'name' => 'adhearsion' }
              ],
              'jruby-1.6.7.2' => [
                { 'name' => 'bundler' },
                { 'name' => 'adhearsion' }
              ]
            }
          }
        ]
      }
    }

    chef.log_level = :debug
  end

  config.package.name = 'mojolingo_dev.box'
end
