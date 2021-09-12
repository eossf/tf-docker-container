module "image" {
  source   = "./image"
  image_in = var.image_in
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
  count   = var.count_in
}

resource "docker_container" "this" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.internal_port_in[count.index]
    external = var.external_port_in[count.index]
  }

  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path"]
      volume_name    = module.volume[count.index].volume_out[volumes.key]
    }
  }
}

module "volume" {
  source          = "./volume"
  count           = var.count_in
  volume_count_in = length(var.volumes_in)
  volume_name_in  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}