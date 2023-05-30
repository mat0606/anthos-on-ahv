# Eject cloud-init
sudo eject

# Setting SELinux to permissive
sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

sudo sestatus | grep "Current mode"

# Use CentOS 8 Vault repo due to CentOS 8 EOL on December 31, 2021
echo "Changing from mirror to vault for CentOS 8 EOL"
cd /etc/yum.repos.d/
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#sudo sed -i -e "s/^mirrorlist/#mirrorlist/g" -e "s/^#baseurl/baseurl/g" -e "s/mirror./vault./g" /etc/yum.repos.d/*.repo


# Disabling firewalld
# Enable these lines if the disk image has firewall enabled
#sudo systemctl stop firewalld
#sudo systemctl disable firewalld