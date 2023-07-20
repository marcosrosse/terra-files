#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Nome do grupo de recursos."
  default = "production"
}

variable "location" {
  description = "Região do Azure."
  default = "eu-west"
}

variable "nsg_name" {
  description = "Network Security Group name."
  default = "nsg-avanade"
}

variable "vpc_name" {
  description = "Virtual Network name."
  default = "vpc-avanade"
}