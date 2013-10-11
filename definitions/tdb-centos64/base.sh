# Base install
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
enabled=1
gpgcheck=0
EOM

# Install NFS client for Virtualbox directory sharing
yum -y install nfs-utils

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config
