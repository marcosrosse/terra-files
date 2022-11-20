module "app" {
  source = "./app"
  hosts = 3
}
output "public_dns" {
  value = module.app.public_dns
}
