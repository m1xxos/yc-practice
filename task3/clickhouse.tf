resource "yandex_mdb_clickhouse_cluster" "main" {
  name        = "main"
  environment = "PRESTABLE"
  network_id  = "enp5phjn29h3p33bc2ss"

  clickhouse {
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 10
    }
  }

  database {
    name = "weather"
  }

  user {
    name     = var.username
    password = var.password
    permission {
      database_name = "weather"
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = "e9bl5p4733k64avthmp4"
  }

  cloud_storage {
    enabled = false
  }

  maintenance_window {
    type = "ANYTIME"
  }
}
