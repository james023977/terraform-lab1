variable "project" {
  description = "你的GCP Project ID"
  type        = string
  default     = "terraform-lab1-408906"
}

variable "region" {
  description = "GCP REGION"
  type        = string
  default     = "asia-east1"
}

variable "billing_account" {
  description = "Billing Account ID"
  type        = string
  default     = "01BDEA-0F057C-8A6708"
}

variable "budget_name" {
  description = "budget name"
  type        = string
  default     = "budget-demo"
}

variable "budget_amount" {
  description = "budget limit"
  type        = number
  default     = "100"
}

variable "sa_id" {
  description = "Service Account ID"
  type        = string
  default     = "demo-server"
}

variable "sa_name" {
  description = "Service Account name"
  type        = string
  default     = "demo"
}


variable "sa_role" {
  description = "Service Account Role"
  type        = string
  default     = "roles/editor"
}

variable "user_email" {
  description = "Service Account user email 你的GCP E-Mail"
  type        = string
  default     = "user:james023977@gmail.com"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "vpc-demo"
}

variable "pub_sub_name" {
  description = "public subnet name"
  type        = string
  default     = "public"
}

variable "ip_cidr_range" {
  type    = string
  default = "10.10.110.0/24"
}

#variable "private_sub_name" {
#  type    = string
#  default = "private"
#}

variable "fw_22_name" {
  description = "public subnet name"
  type        = string
  default     = "allow-tcp-22"
}

variable "fw_80_name" {
  description = "public subnet name"
  type        = string
  default     = "allow-tcp-80"
}

variable "fw_8080_name" {
  description = "public subnet name"
  type        = string
  default     = "allow-tcp-8080"
}

#variable "fw_3306_name" {
#  type    = string
#  default = "allow-mysql"
#}



variable "db_name" {
  description = "public subnet name"
  type        = string
  default     = "sql-demo"
}

variable "vm_name" {
  description = "vm instance name"
  type        = string
  default     = "vm-demo"
}

variable "vm_group_name" {
  description = "instance group name"
  type        = string
  default     = "group-demo"
}

variable "url_map_lb" {
  description = "load balancer name"
  type        = string
  default     = "load-balancer-demo"
}

variable "ssl" {
  description = "ssl certificate"
  type        = string
  default     = "ssl-demo01"
}

variable "backend" {
  description = "backend name"
  type        = string
  default     = "back-end"
}

#variable "bucket_name" {
#  description = "bucket name"
#  type        = string
#  default     = "chc103-demo-${random_id.unique_suffix.hex}"
#}


variable "location" {
  description = "your location"
  type        = string
  default     = "asia-east1"
}

variable "zone" {
  description = "your zone"
  type        = string
  default     = "asia-east1-a"
}
