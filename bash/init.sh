SECRET_NAME=$(terraform output -raw ls__terraform_state_name)

STATIC_ACCESS_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_access_key_entry)
STATIC_SECRET_KEY_ENTRY=$(terraform output -raw sa__terraform_static_access_key_entry_for_secret_key_entry)

AWS_ACCESS_KEY_ID=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_ACCESS_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')
AWS_SECRET_ACCESS_KEY=$(YC_CLI_INITIALIZATION_SILENCE=true yc lockbox payload get --name $SECRET_NAME --format json | jq -r --arg key "$STATIC_SECRET_KEY_ENTRY" '.entries[] | select(.key == $key) | .text_value')

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env

source .env && terraform init -backend-config=bucket="$(terraform output -raw sb__terraform_state_bucket)" -reconfigure && rm *tfstate*

