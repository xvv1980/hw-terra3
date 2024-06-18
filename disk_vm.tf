resource "yandex_compute_disk" "default" {
  count = 3
  name     = "disk${count.index+1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size = "1"
}

resource "yandex_compute_instance" "storages" {

  name        = "storage1"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }
 
 dynamic "secondary_disk" {
    for_each = yandex_compute_disk.default
    content {
      disk_id     = secondary_disk.value["id"]
    }
  }

  metadata = {
         serial-port-enable = 1,
         ssh-keys           = "ubuntu:${local.ssh-keys}"
    }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}