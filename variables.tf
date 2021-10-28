variable "env" {
    default =  "dev"
}

variable "create_vpc" {
  default = true
}

variable "vpc_id" {
  default = ""
}

variable "private_subnets_ids" {
  default = []
  type = list
}

variable "public_subnets_ids" {
  default = []
  type = list
}

variable "region" {
    default = "us-east-1"
}

variable "vpc_name" {
    default = "project_eks_vpc"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}

variable "private_subnets"{
    type = list
    default = ["10.1.1.0/24","10.1.2.0/24"]
}

variable "public_subnets"{
    type = list
    default = ["10.1.3.0/24","10.1.4.0/24"]
}

variable "enable_natgateway" {
  default = true
}

variable "enable_vpngateway" {
  default = false
}

variable "external_nat_ip_ids" {
  default = [""]
  type = list
}
variable "count_eip_nat" {
  default = 1
}

variable "owner_tag" {
    default = "DevOps Team"
}
