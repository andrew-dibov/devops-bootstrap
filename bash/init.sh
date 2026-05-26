#!/bin/bash

YC_TOKEN=""
while [[ -z "$YC_TOKEN" ]]; do
  printf "YC token [https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token] : "
  read YC_TOKEN
  if [[ -z "$YC_TOKEN" ]]; then
    printf "YC token can not be empty"
  fi
done

cat > .env <<EOF
export YC_TOKEN=$YC_TOKEN
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
EOF
source .env

mv backend.s3.tf backend.s3.tf.disabled
terraform init && terraform apply -auto-approve

SECRET_NAME=$(terraform output -raw ls__terraform_state_name)

STATIC_ACCESS_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_access_key_entry)
STATIC_SECRET_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_secret_key_entry)

AWS_ACCESS_KEY_ID=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_ACCESS_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')
AWS_SECRET_ACCESS_KEY=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_SECRET_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env
source .env

S3_BUCKET_NAME=$(terraform output -raw sb__terraform_state_bucket)

mv backend.s3.tf.disabled backend.s3.tf
terraform init -backend-config=bucket="$S3_BUCKET_NAME" -force-copy -reconfigure && rm *tfstate*
