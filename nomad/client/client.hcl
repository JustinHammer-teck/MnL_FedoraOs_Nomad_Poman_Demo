log_level= "INFO"
data_dir = "/home/$user/nomad-client-data/"

name = "client-2"

datacenter = "data-center-1"

client {
  enabled = true
  servers = ["172.27.8.181:4647"]
}

plugin "nomad-driver-podman" {
  config {
    socket_path = "unix:///run/podman/podman.sock"
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

ports {
  http = 5656
}