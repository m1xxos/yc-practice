resource "yandex_compute_instance" "from-terraform-vm" {
  name = "from-terraform-vm"
  platform_id = "standard-v1"
  zone = "ru-central1-a"

  resources {
    cores = 2
    memory = 2
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.from-terraform-subnet.id
    nat = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8nfil295joido42s12"
    }
  }
}