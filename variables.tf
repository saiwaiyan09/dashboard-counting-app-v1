variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "swy"
}

variable "environment" {
  default     = "Production"
  description = "target environment"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "dashboard-counting-v1-vpc"
}


variable "vpc_cidr" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "192.168.0.0/24"
}

variable "subnet_public" {
  description = "The address prefix to use for the subnet."

  default = "192.168.0.0/26"
}

variable "subnet_private" {
  description = "The address prefix to use for the subnet."
  default     = "192.168.0.64/26"
}
variable "azs" {
  description = "Availabily Zone inside VPC"
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}


variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}
variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

