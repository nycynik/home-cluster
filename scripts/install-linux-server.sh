#!/bin/bash

# Installation on linux.
# 2/26/2025 - Mike Lynch

# ====================================
# some fun colors
# ====================================
# Define colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m' # No Color

# ====================================
# Ask user for installation type
# ====================================
echo -e "${YELLOW}Please select the installation type:${NC}"
echo -e "1) Server"
echo -e "2) Client"
echo -e "3) Both"
read -p "Enter your choice (1/2/3): " choice

# it's a bit long winded, but it's easier to maintain to have the configs
# in variables instead of separate files. This next block is just the three
# different configurations for the three different choices.
case $choice in
    1)
        CONFIG_CONTENT=$(cat <<EOF
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"

# Server configuration
server {
  enabled = true
  bootstrap_expect = 1  # Since this is a single server setup
}

# Networking configuration
ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}
EOF
)
        ;;
    2)
        CONFIG_CONTENT=$(cat <<EOF
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"

# Client configuration
client {
  enabled = true
  servers = ["127.0.0.1:4647"]  # Local server address
  
  # Enable Docker driver
  options = {
    "driver.raw_exec.enable" = "1"
    "docker.privileged.enabled" = "true"
  }
}

# Enable Docker driver globally
plugin "docker" {
  config {
    allow_privileged = true
  }
}
EOF
)
        ;;
    3)
        CONFIG_CONTENT=$(cat <<EOF
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"

# Server configuration
server {
  enabled = true
  bootstrap_expect = 1  # Since this is a single server setup
}

# Client configuration
client {
  enabled = true
  servers = ["127.0.0.1:4647"]  # Local server address
  
  # Enable Docker driver
  options = {
    "driver.raw_exec.enable" = "1"
    "docker.privileged.enabled" = "true"
  }
}

# Networking configuration
ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}

# Enable Docker driver globally
plugin "docker" {
  config {
    allow_privileged = true
  }
}
EOF
)
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting...${NC}"
        exit 1
        ;;
esac


# ====================================
# Download and install Nomad
# ====================================
# install nomad
if ! command -v nomad &> /dev/null
then
    echo -e "${YELLOW}🔍 Nomad not found, installing...${NC}"
    # install nomad
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install nomad
    echo -e "${GREEN}✅ Nomad installed successfully!${NC}"
else
    echo -e "${GREEN}✅ Nomad is already installed, skipping installation...${NC}"
fi

# create config directories
sudo mkdir -p /etc/nomad.d
sudo chmod 700 /etc/nomad.d

# create configuration file if it does not exist
if [ ! -f /etc/nomad.d/nomad.hcl ]; then
    sudo cat $CONFIG_FILE >> /etc/nomad.d/nomad.hcl
    echo -e "${GREEN}✅ Nomad configuration file created.${NC}"
else
    echo -e "${BLUE}ℹ️ Nomad configuration file already exists, skipping creation...${NC}"
fi

# Now start nomad as a service
sudo systemctl enable nomad
sudo systemctl start nomad

# verify nomad is running
if systemctl is-active --quiet nomad; then
    echo -e "${GREEN}✅ Nomad is running.${NC}"
    echo -e "For node information, you can run: ${GREEN}nomad node status${NC}"
    echo -e "For job information, you can run: ${GREEN}nomad job status${NC}"
    echo -e "For allocation information, you can run: ${GREEN}nomad alloc status${NC}"
    echo -e "local server is running at: ${GREEN}The Nomad UI will be available at http://localhost:4646${NC}"
else
    echo -e "${RED}❌ Nomad is not running.${NC}"
    echo -e "Something went wrong, you might want to check the logs."
    echo -e "You can check the logs by running: ${GREEN}journalctl -u nomad${NC}"
fi

echo -e "${GREEN}🎉 Installation complete!${NC}"
 
