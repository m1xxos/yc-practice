resource "yandex_mdb_clickhouse_cluster" "main" {
  name        = "main"
  environment = "PRESTABLE"
  network_id  = "enp5phjn29h3p33bc2ss"

  clickhouse {
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  database {
    name = "db_name"
  }

  user {
    name     = "user"
    password = "your_password"
    permission {
      database_name = "db_name"
    }
    settings {
      max_memory_usage_for_user               = 1000000000
      read_overflow_mode                      = "throw"
      output_format_json_quote_64bit_integers = true
    }
    quota {
      interval_duration = 3600000
      queries           = 10000
      errors            = 1000
    }
    quota {
      interval_duration = 79800000
      queries           = 50000
      errors            = 5000
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = "e9bl5p4733k64avthmp4"
  }

  format_schema {
    name = "test_schema"
    type = "FORMAT_SCHEMA_TYPE_CAPNPROTO"
    uri  = "https://storage.yandexcloud.net/ch-data/schema.proto"
  }

  cloud_storage {
    enabled = false
  }

  maintenance_window {
    type = "ANYTIME"
  }
}
