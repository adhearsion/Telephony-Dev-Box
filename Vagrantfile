Vagrant.configure("2") do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.librarian_chef.cheffile_dir = "."

  config.vm.define :adhearsion do |adhearsion|
    adhearsion.vm.network :private_network, ip: "10.203.175.10"
    adhearsion.vm.hostname = "adhearsion.local-dev.mojolingo.com"

    adhearsion.vm.provider :virtualbox do |vb|
      vb.name = "TDB-adhearsion"
    end

    adhearsion.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "java"
      chef.add_recipe "mojolingo-misc::pcre"
      chef.add_recipe "ruby_build"
      chef.add_recipe "rbenv::user"

      chef.log_level = :debug

      chef.json = {
        'rbenv' => {
          'user_installs' => [
            { 'user'    => 'vagrant',
              'rubies'  => ['2.0.0-p247', 'jruby-1.7.4'],
              'global'  => '2.0.0-p247',
              'gems'    => {
                '2.0.0-p247' => [
                  { 'name' => 'bundler' },
                  { 'name' => 'adhearsion' }
                ],
                'jruby-1.7.4' => [
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
    public_ip = "10.203.175.11"

    asterisk.vm.network :private_network, ip: public_ip
    asterisk.vm.hostname = "asterisk.local-dev.mojolingo.com"

    asterisk.vm.provider :virtualbox do |vb|
      vb.name = "TDB-asterisk"
    end

    asterisk.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "asterisk"
      chef.add_recipe "asterisk::package"
      chef.add_recipe "asterisk::config"
      chef.add_recipe "asterisk::unimrcp"

      chef.log_level = :debug

      chef.json = {
        asterisk: {
          sip_conf_context: 'adhearsion',
          manager_ip_address: public_ip,
          manager_permit: '0.0.0.0/0.0.0.0',
          manager_read_perms: %w{all},
          manager_write_perms: %w{all},
          unimrcp: {
            server_ip: "10.203.175.14",
            client_ip: public_ip,
            rtp_ip: public_ip,
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

    freeswitch.vm.network :private_network, ip: public_ip
    freeswitch.vm.hostname = "freeswitch.local-dev.mojolingo.com"

    freeswitch.vm.provider :virtualbox do |vb|
      vb.name = "TDB-freeswitch"
    end

    freeswitch.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "freeswitch"

      chef.log_level = :debug

      chef.json = {
        freeswitch: {
          tls_only: false,
          local_ip: public_ip,
          dialplan: {
            head_fragments: '<extension name="adhearsion">
  <condition>
    <action application="rayo"/>
  </condition>
</extension>'
          }
        }
      }
    end
  end

  config.vm.define :lumenvox do |lumenvox|
    domain = "lumenvox.local-dev.mojolingo.com"
    ip     = "10.203.175.14"

    lumenvox.vm.box = 'centos63_64min'
    lumenvox.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
    lumenvox.vm.network :private_network, ip: ip
    lumenvox.vm.hostname = domain

    lumenvox.vm.provider :virtualbox do |vb|
      vb.name = "TDB-lumenvox"
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    lumenvox.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "lumenvox::core"
      chef.add_recipe "lumenvox::client"
      chef.add_recipe "lumenvox::sre"
      chef.add_recipe "lumenvox::media_server"
      chef.add_recipe "lumenvox::tts"
      chef.add_recipe "mojolingo-misc::no_iptables"

      chef.log_level = :debug

      chef.json = {
        'lumenvox' => {
          'core' => {
            'version' => '11.3.100-2.el6'
          },
          'tts' => {
            'version' => '11.3.100-1SF.el6',
            'voices' => [
                {"voice" => "Chloe",
                 "version" => "11.3.100-1"
                }
            ]
          },
          'sre' => {
            'version' => '11.3.100-2.el6',
            'language_packs' => [{
              "language" => "BritishEnglish",
              "version" => "11.3.100-1"
            }]
          },
          'media_server' => {
            'version' => '11.3.100-2.el6',
            'mrcp_server_ip' => ip
          },
          'client' => {
            'version' => '11.3.100-2.el6',
            'license_servers' => ["208.52.151.220"],
            'authentication_username' => ENV['LUMENVOX_USERNAME'],
            'authentication_password' => ENV['LUMENVOX_PASSWORD'],
            'default_tts_voice' => "default",
            'default_tts_language' => "en-GB"
          }
        }
      }
    end
  end

  config.vm.define :loadtest do |loadtest|
    loadtest.vm.box = 'precise64'
    loadtest.vm.network :private_network, ip: '10.203.175.15'
    loadtest.vm.hostname = 'loadtest.local-dev.mojolingo.com'

    loadtest.vm.provider :virtualbox do |vb|
      vb.name = "TDB-loadtest"
    end

    loadtest.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "sipp"
      chef.add_recipe "wav2rtp"
      chef.add_recipe "ruby_build"
      chef.add_recipe "rbenv::user"
      chef.add_recipe "sudo"

      chef.log_level = :debug

      chef.json = {
        'rbenv' => {
          'user_installs' => [
            { 'user'    => 'vagrant',
              'rubies'  => ['1.9.3-p448'],
              'global'  => '1.9.3-p448',
              'gems'    => {
                '1.9.3-p448' => [
                  { 'name' => 'sippy_cup' }
                ]
              }
            }
          ]
        },
        "authorization" => {
          "sudo" => {
            "users" => ["vagrant"],
            "passwordless" => "true"
          }
        },
      }
    end
  end
end
