apt-get -y update
apt-get -y upgrade
apt-get clean

# Install NFS client for Virtualbox directory sharing
apt-get -y install nfs-common
