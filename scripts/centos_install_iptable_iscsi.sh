# Install iptables but disable it (https://github.com/moby/moby/issues/41799 & https://cloud.google.com/compute/docs/troubleshooting/known-issues)
echo "Installing iptable services"
sudo dnf install -y iptables-services
echo "Check config iptable off"
sudo chkconfig iptables off

# Install iSCSI and NFS CentOS packages for Nutanix Volumes and Files CSI support
echo "Installing iscsi-initiator"
sudo dnf install -y iscsi-initiator-utils nfs-utils
echo "Enabling iscsid"
sudo systemctl enable iscsid
sudo systemctl start iscsid