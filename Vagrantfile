Vagrant.configure("2") do |config|
  config.vm.box = 'bento/ubuntu-14.04'
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.define :adhearsion do |adhearsion|
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

      chef.log_level = :info
    end
  end

  config.vm.define :asterisk do |asterisk|
    public_ip = "10.203.175.11"

    asterisk.vm.network :private_network, ip: public_ip
    asterisk.vm.hostname = "asterisk.local-dev.mojolingo.com"

    asterisk.vm.provider :virtualbox do |vb|
      vb.name = "TDB-asterisk"
      #vb.gui = true
    end

    asterisk.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "asterisk"

      chef.log_level = :info

      chef.json = {}
    end
  end

  config.vm.define :freeswitch do |freeswitch|
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

      chef.log_level = :info

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

    lumenvox.vm.box = 'bento/centos-6.7'
    lumenvox.vm.network :private_network, ip: ip
    lumenvox.vm.hostname = domain

    lumenvox.vm.provider :virtualbox do |vb|
      #vb.gui = true
      vb.name = "TDB-lumenvox"
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    lumenvox.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.roles_path     = "roles"

      chef.add_role "lumenvox"

      chef.log_level = :info

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

      chef.log_level = :info
    end
  end
end
