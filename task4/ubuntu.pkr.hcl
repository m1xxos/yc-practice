variable "YC_FOLDER_ID" {
  type = string
  default = env("YC_FOLDER_ID")
}

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

source "yandex" "yc-ubuntu" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "Yandex Cloud Ubuntu image"
  image_family        = "my-images"
  image_name          = "yc-my-nginx"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-ssd"
  zone                = "${var.YC_ZONE}"
}

build {
  sources = ["source.yandex.yc-ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update -q",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx"
    ]
  }
}
