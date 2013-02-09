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
          'artifacts' => {
            'url' => 'https://prism-app-server.s3.amazonaws.com/daily/prism-trunk_C201209131230_0-x64.bin',
            'checksum' => 'aa58eeea42ddc5c2e2ddef60c35d7d757508ebd1ff8b35d8e495a5c90e8b18bc'
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
            'artifact' => 'http://ci.voxeolabs.net/jenkins/job/Rayo/204/artifact/rayo-war/target/rayo.b204.war',
            'checksum' => '46d928684555dc4c8aa2bf7f046b78f4a751f82c7c85aa8d4245101d38340635',
            'domains'  => [domain]
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
          inbound_proxy_media: false,
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
end
