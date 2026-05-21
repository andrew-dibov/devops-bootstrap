variable "sa__terraform_name" {
  type    = string
  default = "sa--terraform"
}

variable "sa__terraform_description" {
  type    = string
  default = "Service account for Terraform"
}

variable "sa__terraform_key_description" {
  type    = string
  default = "Service account key"
}

variable "sa__terraform_static_access_key_description" {
  type    = string
  default = "Service account static access key"
}

variable "sa__terraform_static_access_key_entry_for_access_key_entry" {
  type    = string
  default = "sa__terraform_static_access_key"
}

variable "sa__terraform_static_access_key_entry_for_secret_key_entry" {
  type    = string
  default = "sa__terraform_static_secret_key"
}
