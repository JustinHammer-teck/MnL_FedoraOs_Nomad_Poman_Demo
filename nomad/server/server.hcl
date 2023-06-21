data_dir  = "/home/eugene/nomad-srv-data"
bind_addr = "0.0.0.0"
log_level = "DEBUG"
datacenter = "data-center-1"


advertise {
  http = "172.27.8.181" #default port 4646
  rpc = "172.27.8.181"  #default port 4647
  serf = "172.27.8.181" #default port 4648
}

server {
  # license_path is required for Nomad Enterprise as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/license.hclic"
  enabled          = true
  bootstrap_expect = 1 # Expected server to boostrap 
}


