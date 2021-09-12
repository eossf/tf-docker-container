resource "docker_image" "this" {
  name         = var.image_in
  keep_locally = true
}