resource "yandex_lockbox_secret" "ls__terraform_key" {
  name = var.ls__terraform_key_name
}

resource "yandex_lockbox_secret_version" "ls__terraform_key_version" {
  secret_id = yandex_lockbox_secret.ls__terraform_key.id

  entries {
    key = "ls__terraform_key"
    text_value = jsonencode({
      id                 = yandex_iam_service_account_key.sa__terraform_key.id
      service_account_id = yandex_iam_service_account_key.sa__terraform_key.service_account_id
      created_at         = yandex_iam_service_account_key.sa__terraform_key.created_at
      key_algorithm      = yandex_iam_service_account_key.sa__terraform_key.key_algorithm
      public_key         = yandex_iam_service_account_key.sa__terraform_key.public_key
      private_key        = yandex_iam_service_account_key.sa__terraform_key.private_key
    })
  }
}

# ---

resource "yandex_lockbox_secret" "ls__terraform_state" {
  name = var.ls__terraform_state_name
}
