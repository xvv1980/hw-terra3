data "yandex_compute_image" "ubuntu" {
  family = var.project.vm_image_family
}

resource "yandex_compute_instance" "web-servers" {
  depends_on = [resource.yandex_compute_instance.db-servers]

  count = 2

  name        = "web-${count.index+1}"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  metadata = var.project.metadata

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  allow_stopping_for_update = true
}