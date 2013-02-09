Vagrant::Config.run do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.define :adhearsion do |adhearsion|
    adhearsion.vm.network :hostonly, "192.168.10.10"
    adhearsion.vm.host_name = "adhearsion.local-dev.mojolingo.com"

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
              'rubies'  => ['1.9.3-p286'],
              'global'  => '1.9.3-p286',
              'gems'    => {
                '1.9.3-p286' => [
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
    asterisk.vm.host_name = "asterisk.local-dev.mojolingo.com"

    asterisk.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "asterisk"
      chef.add_recipe "asterisk::unimrcp"

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
    domain = "prism.local-dev.mojolingo.com"
    ip     = "192.168.10.12"

    prism.vm.box = 'centos63_64min'
    prism.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
    prism.vm.network :hostonly, ip
    prism.vm.host_name = domain
    prism.vm.customize ["modifyvm", :id, "--memory", 1024]

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
    public_ip = "192.168.10.13"

    freeswitch.vm.network :hostonly, public_ip
    freeswitch.vm.host_name = "freeswitch.local-dev.mojolingo.com"

    freeswitch.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt"
      chef.add_recipe "freeswitch"

      chef.log_level = :debug

      chef.json = {
        freeswitch: {
          git_branch: 'master',
          tls_only: false,
          local_ip: public_ip,
          dialplan: {
            head_fragments: '<extension name="Adhearsion">
  <condition field="destination_number" expression=".*$">
    <action application="park"/>
  </condition>
</extension>'
          }
        }
      }
    end
  end

  config.vm.define :lumenvox do |lumenvox|
    domain = "lumenvox.local-dev.mojolingo.com"
    ip     = "192.168.10.14"

    lumenvox.vm.box = 'centos63_64min'
    lumenvox.vm.network :hostonly, ip
    lumenvox.vm.host_name = domain

    lumenvox.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.data_bags_path = "data_bags"
      chef.add_recipe "lumenvox"
      chef.add_recipe "mojolingo-misc::no_iptables"

      chef.log_level = :debug

      chef.json = {
        'lumenvox' => {
          'tts' => {
            'voices' => [
                {"voice" => "Chloe",
                 "version" => "10.5.110-1"
                }
            ]
          },
          'sre' => {
            'language_packs' => [{
              "language" => "BritishEnglish",
              "version" => "10.5.110-1"
            }]
          },
          'media_server' => {
            'mrcp_server_ip' => ip
          },
          'client' => {
            'license_servers' => ["208.52.151.220"],
            'authentication_username' => ENV['LUMENVOX_USERNAME'],
            'authentication_password' => ENV['LUMENVOX_PASSWORD'],
            'default_tts_voice' => "Chloe",
            'default_tts_language' => "en-GB"
          }
        }
      }
    end
  end
end
