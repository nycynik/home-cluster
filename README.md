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

you can do this remotely as well.

    wget 

