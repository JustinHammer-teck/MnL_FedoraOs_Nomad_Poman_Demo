log_level= "DEBUG"
data_dir = "/home/eugene/nomad-client-data"
plugin_dir = "/home/eugene/nomad-driver-podman/plugins"
name = "client-2"
datacenter = "data-center-1"

client {
  enabled = true
  servers = ["172.27.8.181:4647"]
}

plugin "nomad-driver-podman" {
  config {
    volumes {
      enabled      = true
      selinuxlabel = "z"
    }
  }
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}