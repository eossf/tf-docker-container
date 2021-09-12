output "container_access" {
  value = { for x in docker_container.this[*] : x.name => join(":", x.ip_address[*], x.ports[*]["external"]) }
}
