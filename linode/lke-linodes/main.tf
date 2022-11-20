terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.27.1"
    }
  }
}

provider "linode" {
  token = var.token
}

resource "linode_instance" "instance" {
    for_each = var.k8s_names

    label = each.value
    image = var.image
    region = var.region
    type = var.linodeType
    root_pass = var.root_pass

    group = var.group
    tags = var.tags
    swap_size = var.swap_size
    private_ip = true
}

resource "linode_instance" "rancher" {
    label = "rancher"
    image = var.image
    region = var.region
    type = var.linodeType
    root_pass = var.root_pass

    group = var.group
    tags = var.tags 
    swap_size = var.swap_size
    private_ip = true
}

# output "instances_private_ips" {
#   count = length(var.k8s_names)
#   value = linode_instance.instance[count.index].private_ip_address
# }

# output "instances_ip_address" {
#   count = length(var.k8s_names)
#   value = linode_instance.instance[count.index].ipv4
# }

output "rancher_private_ips" {
  value = linode_instance.rancher.private_ip_address
}

output "rancher_ip_address" {
  value = linode_instance.rancher.ipv4
}