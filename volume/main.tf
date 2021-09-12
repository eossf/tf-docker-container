resource "docker_volume" "this" {
  count = var.volume_count_in
  name  = "${var.volume_name_in}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
}