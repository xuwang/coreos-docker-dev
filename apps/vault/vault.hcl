backend "etcd" {
  address = "http://127.0.0.1:2379"
  advertise_addr = "http://127.0.0.1:2379"
  path = "vault"
  sync = "yes"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 0
  tls_cert_file = "/var/lib/apps/certs/etcd.crt"
  tls_key_file = "/var/lib/apps/certs/etcd.key"
}

/* Need to install statesite for this to work 
telemetry {
  statsite_address = "127.0.0.1:8125"
  disable_hostname = true
}
*/
