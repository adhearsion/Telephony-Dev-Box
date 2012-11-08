1. Install [virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. Install [vagrant](http://vagrantup.com)
3. Install Ruby 1.9.3 (via rbenv or rvm) and librarian (`gem install librarian`).
4. Clone this repository (`git clone https://github.com/mojolingo/Telephony-Dev-Box.git`) if you have git installed, or download [an archive](https://github.com/mojolingo/Telephony-Dev-Box/zipball/master).
5. Pull in cookbook dependencies (`librarian-chef install`).
6. Build the VMs:
This project ships with configuration for each of the three supported telephony engines: Asterisk, FreeSWITCH and PRISM.
If you simply type `vagrant up` then one VM will be created for each engine, as well as a VM containing a working Adhearsion environment.
However, this will create four virtual machines! You can easily bring up just the instance(s) you want by typing any combination of the below commands:
  * `vagrant up adhearsion`
  * `vagrant up asterisk`
  * `vagrant up freeswitch`
  * `vagrant up prism`

One thing to note is that the "adhearsion" VM is especially optional.  Most of the Mojo Lingo developers simply run Adhearsion locally. We provided a VM for those users who had a difficult time getting a Ruby build running on their system. If you already have a functional Ruby environment (with RubyGems) then feel free to just `gem install adhearsion` and keep going.

7. (Asterisk and FreeSWITCH Only): Connect your softphone
The TDB VMs contain preconfigured "usera" and "userb" accounts for softphones. Use the following credentials to register:

* Username: usera@asterisk.local-dev.mojolingo.com / Password: usera
* Username: userb@asterisk.local-dev.mojolingo.com / Password: userb

