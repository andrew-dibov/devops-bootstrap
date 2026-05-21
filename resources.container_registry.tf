resource "yandex_container_registry" "cr__application" {
  name      = var.cr__application_name
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id
}
