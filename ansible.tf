resource "local_file" "inventory" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.web-servers,
    dbservers =  yandex_compute_instance.db-servers,
    storages =   [yandex_compute_instance.storages]
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}
