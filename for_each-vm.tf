resource "yandex_compute_instance" "db-servers" {
  for_each = toset(["0","1"])

  name        = var.vm["${each.key}"].vm_name
  platform_id = var.vm["${each.key}"].platform_id

  resources {
    cores         = var.vm["${each.key}"].cores
    memory        = var.vm["${each.key}"].memory
    core_fraction = var.vm["${each.key}"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = var.vm["${each.key}"].boot_disk_size
    }
  }

  #metadata = var.project.metadata
  metadata = {
         serial-port-enable = 1,
         ssh-keys           = "ubuntu:${local.ssh-keys}"
    }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  allow_stopping_for_update = true
}