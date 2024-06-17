resource "yandex_compute_instance" "db-servers" {
  for_each = toset(["0","1"])

  name        = var.vms["${each.key}"].vm_name
  platform_id = var.db_list["${each.key}"].platform_id

  resources {
    cores         = var.db_list["${each.key}"].cores
    memory        = var.db_list["${each.key}"].memory
    core_fraction = var.db_list["${each.key}"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = var.db_list["${each.key}"].boot_disk_size
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