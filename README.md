# Stage A

[OAuth токен](https://yandex.cloud/en/docs/iam/concepts/authorization/oauth-token)

```bash

cat > .env <<EOF
export YC_TOKEN=<oauth-token>
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
EOF

# положи токен

source .env && terraform init && terraform apply -auto-approve
```

# Stage B

```bash
sudo chmod +x bash/*

./bash/init.sh && unset YC_TOKEN
./bash/apply.sh
```
