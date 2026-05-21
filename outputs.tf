output "sb__terraform_state_bucket" {
  value     = yandex_storage_bucket.sb__terraform_state.bucket
  sensitive = true
}

output "ls__terraform_state_name" {
  value     = yandex_lockbox_secret.ls__terraform_state.name
  sensitive = true
}

output "sa__terraform_static_access_key_entry_for_access_key_entry" {
  value     = var.sa__terraform_static_access_key_entry_for_access_key_entry
  sensitive = true
}

output "sa__terraform_static_access_key_entry_for_secret_key_entry" {
  value     = var.sa__terraform_static_access_key_entry_for_secret_key_entry
  sensitive = true
}
