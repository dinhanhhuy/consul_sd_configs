node_name  = "consul-client"
server     = false
datacenter = "dc1"
data_dir   = "consul/data"
log_level  = "INFO"
retry_join = ["127.0.0.1:8301"]
ports {
  serf_lan = 8311
  dns = 8610
  http = 8510
}
service {
  id      = "mariadb_exporter"
  name    = "mariadb_exporter"
  tags    = ["primary"]
  address = "localhost"
  port    = 9104
  check {
    id       = "mariadb_exporter"
    name     = "mariadb_exporter TCP on port 9104"
    tcp      = "localhost:9104"
    interval = "10s"
    timeout  = "1s"
  }
}