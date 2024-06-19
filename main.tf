resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

output "web" {

  value = [ 
                for web in yandex_compute_instance.web-servers: { "name"=web.name, "id"=web.id, "fqdn"=web.fqdn}           
          ]
}

output "db" {

  value = [ 
                for db in yandex_compute_instance.db-servers: { "name"=db.name, "id"=db.id, "fqdn"=db.fqdn}           
          ]
}