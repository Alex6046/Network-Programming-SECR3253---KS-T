<<<<<<< Updated upstream
FROM python:3.11-slim

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system tools needed for Ansible and Linux info commands
RUN apt-get update && apt-get install -y \
    bash \
    git \
    openssh-client \
    sshpass \
    iputils-ping \
    procps \
    util-linux \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible and Python SSH libraries
RUN pip install --no-cache-dir \
    ansible \
    paramiko
=======
# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install SSH tools and Linux system monitoring tools
RUN apt-get update && apt-get install -y \
    openssh-client \
    sshpass \
    procps \
    util-linux \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible and Python dependencies
RUN pip install --no-cache-dir ansible paramiko ansible-pylibssh ncclient
>>>>>>> Stashed changes

# Install Cisco IOS Ansible collection
RUN ansible-galaxy collection install cisco.ios

<<<<<<< Updated upstream
# Set working directory inside container
WORKDIR /app

# Copy all project files into container
COPY . .

# Make run script executable
RUN chmod +x run_all.sh || true

# Disable Ansible SSH host key checking
ENV ANSIBLE_HOST_KEY_CHECKING=False

# Default command
CMD ["bash", "run_all.sh"]
=======
# Copy project files
COPY . /app

# Start container in bash
CMD ["/bin/bash"]
>>>>>>> Stashed changes
