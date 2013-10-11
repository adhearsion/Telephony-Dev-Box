# Installing the virtualbox guest additions
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` perl
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
yum -y remove gcc make gcc-c++ kernel-devel-`uname -r` perl
