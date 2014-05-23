Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true

  config.vm.define :adhearsion do |adhearsion|
    adhearsion.vm.box = 'tdb-adhearsion'
    adhearsion.vm.box_url = 'build/tdb-adhearsion.box'

    adhearsion.vm.network :private_network, ip: "10.203.175.10"
    adhearsion.vm.hostname = "adhearsion.local-dev.mojolingo.com"

    adhearsion.vm.provider :virtualbox do |vb|
      vb.name = "TDB-adhearsion"
    end

    adhearsion.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "adhearsion"
    end
  end

  config.vm.define :asterisk do |asterisk|
    asterisk.vm.box = 'tdb-asterisk'
    asterisk.vm.box_url = 'build/tdb-asterisk.box'

    public_ip = "10.203.175.11"

    asterisk.vm.network :private_network, ip: public_ip
    asterisk.vm.hostname = "asterisk.local-dev.mojolingo.com"

    asterisk.vm.provider :virtualbox do |vb|
      vb.name = "TDB-asterisk"
    end

    asterisk.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "asterisk"

      chef.json = {}
    end
  end

  config.vm.define :freeswitch do |freeswitch|
    freeswitch.vm.box = 'tdb-freeswitch'
    freeswitch.vm.box_url = 'build/tdb-freeswitch.box'

    public_ip = "10.203.175.13"
    domain = "freeswitch.local-dev.mojolingo.com"

    freeswitch.vm.network :private_network, ip: public_ip
    freeswitch.vm.hostname = domain

    freeswitch.vm.provider :virtualbox do |vb|
      vb.name = "TDB-freeswitch"
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end

    freeswitch.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "freeswitch"

      chef.json = {
        freeswitch: {
          local_ip: public_ip,
          domain: domain
        }
      }
    end
  end

  config.vm.define :lumenvox do |lumenvox|
    domain = "lumenvox.local-dev.mojolingo.com"
    ip     = "10.203.175.14"

    lumenvox.vm.box = 'tdb-lumenvox'
    lumenvox.vm.box_url = 'build/tdb-lumenvox.box'
    lumenvox.vm.network :private_network, ip: ip
    lumenvox.vm.hostname = domain

    lumenvox.vm.provider :virtualbox do |vb|
      vb.name = "TDB-lumenvox"
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    lumenvox.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "lumenvox"

      chef.json = {
        'lumenvox' => {
          'media_server' => {
            'mrcp_server_ip' => ip
          },
          'client' => {
            'authentication_username' => ENV['LUMENVOX_USERNAME'],
            'authentication_password' => ENV['LUMENVOX_PASSWORD'],
          }
        }
      }
    end
  end

  config.vm.define :loadtest do |loadtest|
    loadtest.vm.box = 'tdb-loadtest'
    loadtest.vm.box_url = 'build/tdb-loadtest.box'

    loadtest.vm.network :private_network, ip: '10.203.175.15'
    loadtest.vm.hostname = 'loadtest.local-dev.mojolingo.com'

    loadtest.vm.provider :virtualbox do |vb|
      vb.name = "TDB-loadtest"
    end

    loadtest.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "loadtest"
    end
  end
end
