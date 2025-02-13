variable "subscription_id" {
  description = "azure subscription id"
  type        = string
}

variable "client_id" {
  description = "azure application client id"
  type        = string
}

variable "client_secret" {
  description = "azure client secret"
  type        = string
}

variable "tenant_id" {
  description = "azure tenant id"
  type        = string
}

variable "app_name" {
  description = "application name"
  type        = string
  default     = "greensupermarket"
}

variable "environment" {
  description = "Applicaiton environment"
  type        = string
  default     = "dev"
}

variable "mysql_password" {
  type = string
}