1. Install ruby 1.9.3 and bundler
2. Install virtualbox
3. `bundle install`
4. `rake fetch`
5. `rake boot`
6. (optional) To package the box (while its running) type `rake package` (this will preserve port mapping and create a minimal package)

This instance will be built with prism, rayo and asterisk installed. Because of port conflicts between prism and asterisk, the system will boot with neither app process launched.
Use one of the scripts in /vagrant/scripts to launch the appropriate server as you need. There are also scripts to kill the appropriate process. 

You can start up asterisk by vagrant ssh, then sudo start asterisk (similarly you can sudo stop asterisk). You can't run prism and asterisk at the same time because of port conflicts.

Final note: you can also type `vagrant` from the command prompt to get available commands.
