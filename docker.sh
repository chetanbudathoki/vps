#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting Docker installation on Rocky Linux..."

# Step 1: Update system packages
sudo dnf update -y

# Step 2: Install required dependencies
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2

# Step 3: Add Docker repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Step 4: Install Docker
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# Step 5: Enable and start Docker service
sudo systemctl enable --now docker

# Step 6: Create Docker group and add current user (to avoid using sudo for Docker commands)
sudo groupadd docker || true  # Ignore error if group already exists
sudo usermod -aG docker $USER

# Step 7: Restart Docker service
sudo systemctl restart docker

# Step 8: Verify Docker installation
docker --version && echo "✅ Docker installed successfully!"

# Step 9: Verify Docker service is running
sudo systemctl status docker --no-pager

# Step 10: Test Docker by running a container
echo "🐳 Running a test container..."
docker run --rm hello-world

echo "🎉 Docker setup completed! Please log out and log back in for group changes to take effect."
