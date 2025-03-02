# home-cluster
A repository that helps set up Nomad, Consul, Vault, Docker, traefik for a home lab.


# Nomad
 The script is pretty straightforward. It asks the user for the installation type (server, client, or both), then installs Nomad based on the user’s choice. 
 The script also creates the configuration file for Nomad based on the user’s choice. 
 The script then starts the Nomad service and prints out some useful information. 

 
## Linux OS installation

You can run the script by executing the following command: 

    chmod +x scripts/install-linux-server.sh
    ./scripts/install-linux-server.sh

## OSX installation

    chmod +x scripts/install-osx-server.sh
    ./scripts/install-osx-server.sh

## Remote installation

you can do this remotely as well.

Linux:

     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nycynik/home-cluster/main/scripts/install-linux-server.sh)"

MacOS:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nycynik/home-cluster/main/scripts/install-osx-server.sh)"
 


# ⚠️ Disclaimer
Running remote scripts directly from the internet can be dangerous. You should always review the script before executing it to ensure it does what you expect.

By following the instructions in this README, you accept all risks associated with running this script. I am providing this as-is, with no guarantees, warranties, or support. If something goes wrong—whether it's data loss, security issues, or any unintended consequences—I am not responsible.

Use at your own risk. 🚀

