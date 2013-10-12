if test -f .vmfusion_version ; then

  cd /tmp
  mkdir -p /mnt/cdrom
  mount -o loop /home/vagrant/linux.iso /mnt/cdrom
  tar zxvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
  /tmp/vmware-tools-distrib/vmware-install.pl -d
  rm /home/vagrant/linux.iso
  umount /mnt/cdrom

fi

if test -f .vbox_version ; then

  # Without libdbus virtualbox would not start automatically after compile
  apt-get -y install --no-install-recommends libdbus-1-3

  # The netboot installs the VirtualBox support (old) so we have to remove it
  /etc/init.d/virtualbox-ose-guest-utils stop
  rmmod vboxguest
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
  aptitude -y install dkms

  # Install the VirtualBox guest additions
  apt-get -y install gcc build-essential linux-headers-$(uname -r)
  apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
  VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
  VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
  mount -o loop $VBOX_ISO /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run
  umount /mnt

  # Cleanup VirtualBox
  rm $VBOX_ISO
  apt-get -y remove gcc build-essential linux-headers-$(uname -r)
  apt-get -y remove zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
fi
