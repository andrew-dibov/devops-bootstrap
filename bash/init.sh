SECRET_NAME=$(terraform output -raw ls__terraform_state_name)

STATIC_ACCESS_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_access_key_entry)
STATIC_SECRET_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_secret_key_entry)

export AWS_ACCESS_KEY_ID=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_ACCESS_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')
export AWS_SECRET_ACCESS_KEY=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_SECRET_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')

BUCKET=$(terraform output -raw sb__terraform_state_bucket)
cat > backend.s3.tf <<EOF
terraform {
  backend "s3" {
    bucket   = "$BUCKET"
    key      = "bootstrap/terraform.tfstate"
    region   = "ru-central1"

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
EOF

terraform init -reconfigure && rm *tfstate*

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > aws.env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> aws.env
