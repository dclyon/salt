# install Docker
install_docker:
  pkg.installed:
    - names:
      - docker.io
      - docker-compose

# Ensure Docker service is running
docker_service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: install_docker

# Pull Docker Image (Example: Pulling Ubuntu Image)
pull_ubuntu_image:
  cmd.run:
    - name: docker pull ubuntu:20.04
    - require:
      - service: docker_service

# Running a Docker Container
run_docker_container:
  cmd.run:
    - name: docker run -d --name slurm_container ubuntu:20.04
    - require:
      - cmd: pull_ubuntu_image

# Install SLURM
install_slurm:
  pkg.installed:
    - names:
      - slurm-wlm

# Configuration for SLURM (this is a placeholder, you need actual config)
configure_slurm:
  file.managed:
    - name: /etc/slurm-llnl/slurm.conf
    - source: salt://path/to/your/slurm.conf
    - require:
      - pkg: install_slurm

# Start SLURM Service
slurm_service:
  service.running:
    - name: slurmctld
    - enable: True
    - require:
      - pkg: install_slurm
      - file: configure_slurm

