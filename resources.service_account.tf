resource "yandex_iam_service_account" "sa__terraform" {
  name        = var.sa__terraform_name
  description = var.sa__terraform_description
}

# ---

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_storage_editor" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_vpc_admin" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "vpc.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_compute_editor" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "compute.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_load_balancer_editor" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "load-balancer.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_container_registry_editor" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "container-registry.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa__terraform_lockbox_admin" {
  folder_id = data.yandex_client_config.cc__yandex_cloud.folder_id

  role   = "lockbox.admin"
  member = "serviceAccount:${yandex_iam_service_account.sa__terraform.id}"
}

# ---

resource "yandex_iam_service_account_key" "sa__terraform_key" {
  service_account_id = yandex_iam_service_account.sa__terraform.id

  key_algorithm = "RSA_4096"
  description   = var.sa__terraform_key_description
}

resource "yandex_iam_service_account_static_access_key" "sa__terraform_static_access_key" {
  service_account_id = yandex_iam_service_account.sa__terraform.id
  description        = var.sa__terraform_static_access_key_description

  output_to_lockbox {
    secret_id            = yandex_lockbox_secret.ls__terraform_state.id
    entry_for_access_key = var.sa__terraform_static_access_key_entry_for_access_key_entry
    entry_for_secret_key = var.sa__terraform_static_access_key_entry_for_secret_key_entry
  }
}
