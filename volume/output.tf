output "volume_out" {
  value = docker_volume.this[*].name
}
