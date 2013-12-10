Vagrant.configure("2") do |config|
  config.vm.box = 'tdb-ubuntu1204-v9'
  config.vm.box_url = 'http://ci.mojolingo.com/job/Telephony-Dev-Box-Base-Boxen/9/artifact/tdb-ubuntu1204.box'
  config.berkshelf.enabled = true

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

      chef.log_level = :debug
    end
  end

  config.vm.define :asterisk do |asterisk|
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

      chef.log_level = :debug

      chef.json = {
        asterisk: {
          manager: {
            ip_address: public_ip
          },
          unimrcp: {
            server_ip: "10.203.175.14",
            client_ip: public_ip,
            rtp_ip: public_ip
          }
        }
      }
    end
  end

  config.vm.define :prism do |prism|
    domain = "prism.local-dev.mojolingo.com"
    ip     = "10.203.175.12"

    prism.vm.box = 'centos63_64min'
    prism.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
    prism.vm.network :private_network, ip: ip
    prism.vm.hostname = domain

    prism.vm.provider :virtualbox do |vb|
      vb.name = "TDB-prism"
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end

    prism.vm.provision :chef_solo do |chef|
      chef.provisioning_path = "/vagrant/tmp"
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "yum"
      chef.add_recipe "jmxsh"
      chef.add_recipe "prism"
      chef.add_recipe "rayo"
      chef.add_recipe "mojolingo-misc::no_iptables"

      chef.log_level = :debug

      chef.json = {
        'name' => domain,
        'prism' => {
         'include_monitoring' => false,
          'artifacts' => {
            'url' => 'https://prism-app-server.s3.amazonaws.com/daily/prism-12_3_0_C201303091903_0-x64.bin',
            'checksum' => '9178241729dc89e9a78521341d759c7cc5c8f3ec0b06ba2dc6b4f39017643ea7'
          },
          'user' => 'vagrant',
          'group' => 'vagrant',
          'local_ipv4' => ip,
          'public_ipv4' => ip,
          'nat_mode' => true,
          'relay_port' => false
        },
        'rayo' => {
          'node' => {
            'artifact' => 'http://ci-voxeolabs-net.s3.amazonaws.com/rayo/rayo.b313.war',
            'checksum' => '4b44201a70e3192ed4a9bc298c4cb3de288ca775632ff4430214ecc850452061',
            'domains'  => [domain],
            'routes'   => [".*=usera@#{domain}"]
          }
        }
      }
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

      chef.log_level = :debug

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

    lumenvox.vm.box = 'tdb-centos64-v9'
    lumenvox.vm.box_url = 'http://ci.mojolingo.com/job/Telephony-Dev-Box-Base-Boxen/9/artifact/tdb-centos64.box'
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

      chef.log_level = :debug

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

      chef.log_level = :debug
    end
  end
end
