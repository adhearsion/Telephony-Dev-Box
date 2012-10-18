1. Install [virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. Install [vagrant](http://vagrantup.com)
3. Install Ruby 1.9.3 (via rbenv or rvm) and librarian (`gem install librarian`).
4. Clone this repository (`git clone https://github.com/mojolingo/Telephony-Dev-Box.git`) if you have git installed, or download [an archive](https://github.com/mojolingo/Telephony-Dev-Box/zipball/master).
5. Pull in cookbook dependencies (`librarian-chef install`).
6. Boot all VMs (`vagrant up`) or just the desired VM (eg `vagrant up prism`)
