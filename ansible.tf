resource "local_file" "inventory" {
  content = templatefile("/home/xvv/hm-terra/03/hw-terra3/hosts.tftpl",

  { webservers = yandex_compute_instance.web-servers,
    dbservers =  yandex_compute_instance.db-servers,
    storages =   yandex_compute_instance.storages
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}
