# Переменная словарь для консолидации общих для проекта переменных
# Создана для тренировки сложных структур
variable "project" {
 type = object({
    pref  = string
    author   = string
    vm_image_family  = string
    metadata = object({
    serial-port-enable = number,
    ssh-keys = string
 })
 })
 default = {
    pref = "hw-terra3",
    author = "xvv",
    vm_image_family = "ubuntu-2004-lts",
    metadata = {
         serial-port-enable = 1,
         ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdLgGD5Y1zZQ1EcMOSxtTne857FpnjCaqjU++SnYYAY xvv@host-15"
    }
  }
}

variable "vm" {
  type = list(object({  
                vm_name        = string, 
                platform_id    = string,
                cores          = number,
                memory         = number,
                core_fraction  = number,
                boot_disk_size = number
              })
        )
}


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "metadata" {  
   type = map   
   default=  {
         serial-port-enable = 1,
         ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdLgGD5Y1zZQ1EcMOSxtTne857FpnjCaqjU++SnYYAY xvv@host-15"
    }
}