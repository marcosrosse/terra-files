variable "token" {
    description = "Your Linode API Personal Access Token. (required)"
}

variable "k8s_names" {
    type = set(string)
    default = ["k8s-0","k8s-1","k8s-2"]
}

variable "image" {
    type = string
    default = "linode/ubuntu22.04"
}

variable "region" {
    type = string
    default = "us-central"
}

variable "linodeType" {
    type = string
    default = "g6-standard-2"
}

variable "root_pass" {
    type = string
    default = "potato007"
    sensitive = true
}

variable "group" {
    type = string
    default = "kubernetes"
}

variable "tags" {
    type = list(string)
    default = ["kubernetes"]
}

variable "swap_size" {
    type = number
    default = 256
}