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