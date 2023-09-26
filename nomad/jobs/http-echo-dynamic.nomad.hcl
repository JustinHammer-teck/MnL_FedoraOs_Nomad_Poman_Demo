job "http-echo-dynamic-service" {
  datacenters = ["data-center-1"]

  update {
    max_parallel = 1
    healthy_deadline = "3m"
  }

  group "echo" {
    count = 1
    task "server" {
      driver = "podman"

      config {
          image = "docker.io/hashicorp/http-echo"
          ports = ["http"]
          args = [
              "-listen", ":${NOMAD_PORT_http}",
              "-text", "Hello and welcome to :${NOMAD_IP_http} running on port ${NOMAD_PORT_http}",
          ]
      }

      resources {
        network {
          port "http" {}
        }
      }

      service {
        name = "http-echo"
        port = "http"
        check {
          type     = "http"
          path     = "/health"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}