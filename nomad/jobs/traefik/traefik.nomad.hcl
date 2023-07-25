job "traefik" {
  datacenters = ["data-center-1"]
  type        = "service"

  group "traefik" {
    count = 1

    network {
      port  "http"{
         static = 80
      }
      port  "admin"{
         static = 8080
      }
    }

    service {
      name = "traefik-http"
      provider = "nomad"
      port = "http"
    }

    task "server" {
      driver = "podman"
      config {
        image = "docker.io/library/traefik:latest"
        ports = ["admin", "http"]
        args = [
          "--api.dashboard=true",
          "--api.insecure=true", ### For Test only, please do not use that in production
          "--entrypoints.web.address=:${NOMAD_PORT_http}",
          "--entrypoints.traefik.address=:${NOMAD_PORT_admin}",
          "--providers.nomad=true",
          "--providers.nomad=true",
          "--providers.nomad.endpoint.address=http://[ip-of-server]:4646" ### IP to your nomad server 
        ]
        volumes = [
          "/home/eugene/nomad-srv-data/containers/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }
      service {
        name = "traefik"

        check {
          name     = "alive"
          type     = "tcp"
          port     = "http"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}