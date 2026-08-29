# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Define build argument
ARG USERNAME=alexzam

# Install the packages needed for local Ansible validation
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo vim ansible python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the user with sudo privileges
RUN useradd -m -s /bin/bash ${USERNAME} && \
    mkdir -p /etc/sudoers.d && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Set the working directory to the ansible repository
WORKDIR /home/${USERNAME}/ansible

# Copy the current local files (your Ansible repository) into the container
COPY . /home/${USERNAME}/ansible

# Change ownership of the copied files without using sudo
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/ansible && \
    chmod +x /home/${USERNAME}/ansible/ansible

# Switch to the specified user
USER ${USERNAME}

# Default command
CMD ["bash"]
