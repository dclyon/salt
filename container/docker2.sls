install_docker:
  pkg.installed:
    - names:
      - docker.io

# Pull a Docker image
pull_ubuntu_image:
  cmd.run:
    - name: docker pull ubuntu
    - require:
      - pkg: install_docker

# Create and run a Docker container
create_docker_container:
  cmd.run:
    - name: docker run -d --name=my_salt_minion_container ubuntu
    - require:
      - cmd: pull_ubuntu_image

# Install Salt Minion inside the container
install_salt_minion_in_container:
  docker_container.running:
    - name: my_salt_minion_container
    - image: ubuntu
    - command: /bin/sh -c "apt-get update && apt-get install -y salt-minion && systemctl start salt-minion"
    - require:
      - cmd: create_docker_container

# Additional configurations go here, like setting up the minion's config file

