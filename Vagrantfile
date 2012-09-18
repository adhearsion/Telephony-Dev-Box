Vagrant::Config.run do |config|
  config.vm.box = "precise64"

  config.vm.define :adhearsion do |adhearsion|
    adhearsion.vm.network :hostonly, "192.168.10.10"
    adhearsion.vm.host_name = "adhearsion.mojolingo-dev.local"
    adhearsion.vm.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

    adhearsion.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "java"
      chef.add_recipe "ruby_build"
      chef.add_recipe "rbenv::user"

      chef.log_level = :debug

      chef.json = {
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
    end
  end

  config.vm.define :asterisk do |asterisk|
    public_ip = "192.168.10.11"

    asterisk.vm.network :hostonly, public_ip
    asterisk.vm.host_name = "asterisk.mojolingo-dev.local"
    config.vm.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

    asterisk.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "asterisk"

      chef.log_level = :debug

      chef.json = {
        asterisk: {
          manager_ip_address: public_ip,
          manager_permit: '0.0.0.0/0.0.0.0',
          manager_read_perms: %w{all},
          manager_write_perms: %w{all}
        }
      }
    end
  end

  config.vm.define :prism do |prism|
    domain = "prism.mojolingo-dev.local"

    prism.vm.network :hostonly, "192.168.10.12"
    prism.vm.host_name = domain
    config.vm.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

    config.vm.customize do |vm|
      vm.memory_size = 512 # Bump the memory to accommodate PRISM
    end

    prism.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "java"
      chef.add_recipe "jmxsh"
      chef.add_recipe "prism"
      chef.add_recipe "rayo"

      chef.log_level = :debug

      chef.json = {
        'name' => domain,
        'prism' => {
          'user' => 'vagrant',
          'group' => 'vagrant'
        },
        'rayo' => {
          'node' => {
            'domains' => [domain]
          }
        }
      }
    end
  end

  config.vm.define :freeswitch do |freeswitch|
    public_ip = "192.168.10.13"

    freeswitch.vm.network :hostonly, public_ip
    freeswitch.vm.host_name = "freeswitch.mojolingo-dev.local"

    freeswitch.vm.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

    freeswitch.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "freeswitch"

      chef.json = {
        freeswitch: {
          tls_only: false,
          local_ip: public_ip
        }
      }
    end
  end
end
