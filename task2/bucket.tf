resource "yandex_storage_bucket" "practice2-m1xxos" {
  bucket = "practice2-m1xxos"
  folder_id = var.folder_id
}

resource "yandex_storage_object" "image01" {
  bucket = yandex_storage_bucket.practice2-m1xxos.bucket
  key    = "image01.dat"
  source = "~/Downloads/image01.dat"
  tags = {
    patient = "ivanov"
    status = "ok"
  }
}

resource "yandex_storage_object" "image02" {
  bucket = yandex_storage_bucket.practice2-m1xxos.bucket
  key    = "image02.dat"
  source = "~/Downloads/image02.dat"
  tags = {
    patient = "ivanov"
    status = "ill"
  }
}