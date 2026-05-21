# Stage A

[OAuth токен](https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token)

```bash
echo "export YC_TOKEN=" > .env
# Подставь OAuth токен : не пали в истории
source .env

export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

terraform init && terraform apply -auto-approve
```

# Stage B

```bash
sudo chmod +x bash/*

./bash/init.sh # перегон стейта в бакет
unset YC_TOKEN

./bash/apply.sh # применение изменений
```
