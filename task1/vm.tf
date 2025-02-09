locals {
  subnet_id = "fl8dm4v6nv73qms72iet"
  platform_id = "standard-v3"
}

resource "yandex_compute_image" "ubuntu_2204" {
  source_family = "ubuntu-2204-lts"
}

resource "yandex_compute_disk" "boot-disk-vm1" {
 name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = yandex_compute_image.ubuntu_2204.id
}

resource "yandex_compute_disk" "boot-disk-vm2" {
  name     = "boot-disk-2"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = yandex_compute_image.ubuntu_2204.id
}

resource "yandex_compute_instance" "vm-1" {
  name = "test-vm1"

  resources {
    cores  = 2
    memory = 4
  }
  platform_id = local.platform_id

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-vm1.id
  }

  network_interface {
    subnet_id = local.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "m1xxos:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("startup.sh")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "test-vm2"

  resources {
    cores  = 2
    memory = 4
  }
  platform_id = local.platform_id

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-vm2.id
  }

  network_interface {
    subnet_id = local.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "m1xxos:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("startup.sh")}"
  }
}


output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}
