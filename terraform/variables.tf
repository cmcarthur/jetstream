variable "whitelisted_ips" {
  type = "string"
  description = "A CSV (without spaces!) of IPs to whitelist"
}

variable "redshift_master_username" {
  type = "string"
  default = "root"
}

variable "redshift_master_password" {
  type = "string"
}

variable "redshift_database_name" {
  type = "string"
  default = "redash"
}

variable "redash_backend_username" {
  type = "string"
  default = "root"
}

variable "redash_backend_password" {
  type = "string"
}

variable "public_key_path" {
  type = "string"
  default = "~/.ssh/id_rsa.pub"
}

variable "redash_admin_password" {
  type = "string"
}
