# Install Docker 19.03+
echo "installing yum-utils"
sudo dnf install -y yum-utils
echo "add docker repo"
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
echo "Enabling docker"
sudo systemctl enable docker
sudo systemctl start docker

# Verify you are now running version 19.03+
sudo docker version

# Add your user to the docker group
sudo usermod -aG docker $USER

# Change default cgroup driver to systemd
#echo "creating docker daemon.json"
#cat <<EOF | sudo tee /etc/docker/daemon.json
#{
#  "exec-opts": ["native.cgroupdriver=systemd"],
#  "log-driver": "json-file",
#  "log-opts": {
#    "max-size": "100m"
#  },
#  "storage-driver": "overlay2",
#  "storage-opts": [
#    "overlay2.override_kernel_check=true"
#  ]
#}
#EOF
#sudo systemctl status docker
#echo "restarting docker"
#sudo systemctl restart docker
#echo "docker info cgroup"
#sudo docker info | grep -i cgroup
