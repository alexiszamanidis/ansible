# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Define build argument
ARG USERNAME

# Update package lists
RUN apt-get update

# Install basic packages
RUN apt-get install -y sudo vim

# Clean up to reduce image size
RUN apt-get clean

# Create the user with sudo privileges
RUN useradd -m -s /bin/bash ${USERNAME} && \
    mkdir -p /etc/sudoers.d && \
    echo '${USERNAME} ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Copy the current local files (your Ansible repository) into the container
COPY . /home/${USERNAME}/ansible

# Set the working directory to the ansible repository
WORKDIR /home/${USERNAME}/ansible

# Change ownership of the copied files without using sudo
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/ansible

# Make the install script executable
RUN chmod +x /home/${USERNAME}/ansible/install

# Switch to the specified user
USER ${USERNAME}

# Default command
CMD ["bash"]
