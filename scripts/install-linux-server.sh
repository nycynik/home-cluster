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
    sudo cat ./configs/nomad-template.hcl >> /etc/nomad.d/nomad.hcl
    echo -e "${GREEN}✅ Nomad configuration file created.${NC}"
else
    echo -e "${BLUE}ℹ️ Nomad configuration file already exists, skipping creation...${NC}"
fi

