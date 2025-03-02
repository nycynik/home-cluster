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