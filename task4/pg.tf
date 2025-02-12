resource "yandex_mdb_postgresql_cluster" "test-vm" {
    name = "test-vm"
    environment = "PRESTABLE"
    network_id = yandex_vpc_network.from-terraform-network.id

    config {
        version = "16"
        resources {
          resource_preset_id = "s1.micro"
          disk_type_id       = "network-ssd"
          disk_size = "10"
        }
    }

    host {
      zone = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.from-terraform-subnet.id
    }
}