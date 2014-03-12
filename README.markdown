# Telephony Dev Box

## Installation

1. Install [virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. Install [vagrant](http://vagrantup.com)
3. Clone this repository (`git clone https://github.com/mojolingo/Telephony-Dev-Box.git`) if you have git installed, or download [an archive](https://github.com/mojolingo/Telephony-Dev-Box/zipball/master).
4. Add the [vagrant-berkshelf plugin](https://github.com/riotgames/vagrant-berkshelf) to your Vagrant installation by doing `vagrant plugin install vagrant-berkshelf`.
5. Build the VMs:
This project ships with configuration for various telephony engines: Asterisk and FreeSWITCH, along with a box with Lumenvox TTS & ASR deployed and a load test box (containing [SIPp](http://sipp.sourceforge.net) + [Sippy Cup](https://github.com/bklang/sippy_cup)). If you simply type `vagrant up` then one VM will be created for each engine, as well as a VM containing a working Adhearsion environment. However, this will create five virtual machines! You can easily bring up just the instance(s) you want by typing any combination of the below commands:
  * `vagrant up adhearsion`
  * `vagrant up asterisk`
  * `vagrant up freeswitch`
  * `vagrant up lumenvox`
  * `vagrant up loadtest`

One thing to note is that the "adhearsion" VM is especially optional.  Most of the Mojo Lingo developers simply run Adhearsion locally. We provided a VM for those users who had a difficult time getting a Ruby build running on their system. If you already have a functional Ruby environment (with RubyGems) then feel free to just `gem install adhearsion` and keep going.

## Usage

Generated Adhearsion apps have sample config which targets Telephony Dev Box by default.

### Test
Boot your Adhearsion app and call in. You can dial `usera@[asterisk/freeswitch].local-dev.mojolingo.com`, or any number from a registered endpoint.

### Register your softphone (optional)
The Asterisk and FreeSWITCH VMs contain preconfigured "usera" and "userb" accounts for softphones. Use the following credentials to register:

* Username: usera@[asterisk/freeswitch].local-dev.mojolingo.com / Password: usera
* Username: userb@[asterisk/freeswitch].local-dev.mojolingo.com / Password: userb
