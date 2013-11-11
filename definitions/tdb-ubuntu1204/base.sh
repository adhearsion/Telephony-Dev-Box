apt-get -y update
apt-get -y upgrade
apt-get clean

# Set up passwordless sudo for the vagrant user
( cat <<'EOP'
%vagrant ALL=(ALL) NOPASSWD:ALL
EOP
) > /tmp/vagrant
chmod 0440 /tmp/vagrant
mv /tmp/vagrant /etc/sudoers.d/

# Install NFS client for Virtualbox directory sharing
apt-get -y install nfs-common
