1. Install ruby, gem install vagrant, install virtualbox(4.1.2 is what I used)
2. Download the lucid32 image by typing `vagrant box add base http://files.vagrantup.com/lucid32.box`  (this will take 5 or 6 mins to complete)
3. Download the daily build of prism into the current directory (I used prism-trunk_C201109060002). Save it as prism.bin and make sure the file is marked executable.
4. Download the appropriate version of rayo.war; save it as rayo.war in the current directory
5. Type `vagrant up` (boots the system)
6. (optional) To package the file type (while its running) type `vagrant package --vagrantfile Vagrantfile.pkg` (this will preserve the 8080 port mapping)

you can start up asterisk by vagrant ssh, then sudo start asterisk (similarly you can sudo stop asterisk).  You can run prism and asterisk at the same time because of port conflicts



Just before packaging, log in to the box and enter the following
commands  to shrink the image size
aptitude clean
cat /dev/zero > zero.fill;sync;sleep 1;sync;rm -f zero.fill

Final note: you can also type "vagrant" from the command prompt to get available commands

