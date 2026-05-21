resource "yandex_storage_bucket" "sb__terraform_state" {
  bucket_prefix = var.sb__terraform_state_prefix
  folder_id     = data.yandex_client_config.cc__yandex_cloud.folder_id

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
