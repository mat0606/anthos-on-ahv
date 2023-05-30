

# Remove any previous Docker version
echo "Removing docker"
sudo dnf remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine

echo "Removing podman manpages"
sudo dnf remove podman-manpages
