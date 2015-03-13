# Telephony Dev Box

## Installation

1. Install [virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. Install [vagrant](http://vagrantup.com)
3. Clone this repository (`git clone https://github.com/mojolingo/Telephony-Dev-Box.git`) if you have git installed, or download [an archive](https://github.com/mojolingo/Telephony-Dev-Box/zipball/master).
4. Now cd into the cloned repository by doing: `cd Telephony-Dev-Box`
5. Add the [vagrant-berkshelf plugin](https://github.com/riotgames/vagrant-berkshelf) and [vagrant-omnibus](https://github.com/opscode/vagrant-omnibus) to your Vagrant installation by doing `vagrant plugin install vagrant-berkshelf && vagrant plugin install vagrant-omnibus`.
6. Build the VMs:
This project ships with configuration for various telephony engines: Asterisk and FreeSWITCH, along with a box with Lumenvox TTS & ASR deployed and a load test box (containing [SIPp](http://sipp.sourceforge.net) + [Sippy Cup](https://github.com/bklang/sippy_cup)). If you simply type `vagrant up` then one VM will be created for each engine, as well as a VM containing a working Adhearsion environment. However, this will create five virtual machines! You can easily bring up just the instance(s) you want by typing any combination of the below commands:
  * `vagrant up adhearsion`
  * `vagrant up asterisk`
  * `vagrant up freeswitch`
  * `vagrant up lumenvox`
  * `vagrant up loadtest`

One thing to note is that the "adhearsion" VM is especially optional.  Most of the Mojo Lingo developers simply run Adhearsion locally. We provided a VM for those users who had a difficult time getting a Ruby build running on their system. If you already have a functional Ruby environment (with RubyGems) then feel free to just `gem install adhearsion` and keep going.

## Usage

### Create an Adhearsion app

Configure it to connect to the platform of your choice using one of the following samples:

```ruby
##
# Use with Rayo (FreeSWITCH)
#
config.punchblock.username = "usera@freeswitch.local-dev.mojolingo.com" # Your XMPP JID for use with Rayo
config.punchblock.password = "1" # Your XMPP password
```

```ruby
##
# Use with Asterisk
#
config.punchblock.platform = :asterisk # Use Asterisk
config.punchblock.username = "manager" # Your AMI username
config.punchblock.password = "password" # Your AMI password
config.punchblock.host = "asterisk.local-dev.mojolingo.com" # Your AMI host
```

### Test
Boot your Adhearsion app and call in. You can dial `usera@[asterisk/freeswitch].local-dev.mojolingo.com`, or any number from a registered endpoint.

### Register your softphone (optional)
The Asterisk and FreeSWITCH VMs contain preconfigured "usera" and "userb" accounts for softphones. Use the following credentials to register:

* Username: usera@[asterisk/freeswitch].local-dev.mojolingo.com / Password: usera
* Username: userb@[asterisk/freeswitch].local-dev.mojolingo.com / Password: userb

## Base Boxes

This project includes base box templates for use on Mojo Lingo projects. These base boxes are published at http://ci.mojolingo.com/job/Telephony-Dev-Box-Base-Boxen, and include Chef 11. Ubuntu 12.04 and CentOS 6.4 boxes are available, both 64bit. The main difference between these and other publicly available base boxes is the visibility into their build mechanism and that they *never* change after they are published - new builds always have a new build number in their URL; this way you can be sure of base box stability.

## Common Issues

If your locale is POSIX or C (primarily computers in the United States, or computers using the default US English locale), you may see an error similar to the following:

```
stderr: /opt/chefdk/embedded/lib/ruby/2.1.0/json/common.rb:155:in `encode': "\xE2" on US-ASCII (Encoding::InvalidByteSequenceError)
```

To fix this, simply set a UTF locale:

```bash
LC_ALL=en_US.UTF-8 vagrant up
```
