# Arquivo main.tf

# Definir o provedor do Azure
provider "azurerm" {
  features {}
}

# Criar o recurso de grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = "MeuResourceGroup"
  location = "East US" # Substitua pela região desejada
}

# Criar o Azure SQL Database
resource "azurerm_sql_server" "sql" {
  name                         = "mysqlerver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin" # Substitua pelo nome de login desejado
  administrator_login_password = "Password123!" # Substitua pela senha desejada
}

resource "azurerm_sql_database" "sql_db" {
  name                = "DotNetAppSqlDb_db"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
}

# Criar o Azure Blob Storage
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Criar o Azure App Service
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "MyAppServicePlan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "MyAppService"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }
}

# Criar o Azure Front Door
resource "azurerm_frontdoor" "front_door" {
  name                = "MyFrontDoor"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = "production"
  }
}

# Configurar o Front Door para encaminhar tráfego para o App Service
resource "azurerm_frontdoor_frontend_endpoint" "frontend_endpoint" {
  name                      = "MyFrontendEndpoint"
  resource_group_name       = azurerm_resource_group.rg.name
  front_door_name           = azurerm_frontdoor.front_door.name
  host_name                 = "example.com" # Substitua pelo domínio do seu website
  session_affinity_enabled  = false
  priority                  = 1
  enabled_state             = "Enabled"
  forwarding_protocol       = "HttpsOnly"
  custom_https_provisioning_enabled = true
  custom_https_configuration {
    certificate_source = "FrontDoor"
    protocol_type      = "SNI"
  }
}

resource "azurerm_frontdoor_backend_pool" "backend_pool" {
  name                = "MyBackendPool"
  resource_group_name = azurerm_resource_group.rg.name
  front_door_name     = azurerm_frontdoor.front_door.name
  load_balancing_enabled = true
  sample_size = 4
  successful_samples_required = 2
  healthy_host_count = 2

  backend {
    address = azurerm_app_service.app_service.default_site_hostname
    http_port = 443
    https_port = 443
    priority = 1
    weight = 50
  }
}

resource "azurerm_frontdoor_backend_routing_rule" "backend_routing_rule" {
  name                = "MyBackendRoutingRule"
  resource_group_name = azurerm_resource_group.rg.name
  front_door_name     = azurerm_frontdoor.front_door.name
  backend_pool_name   = azurerm_frontdoor_backend_pool.backend_pool.name
  accepted_protocols  = ["Https"]
  patterns_to_match   = ["/*"]
  route_type          = "Forward"
  forwarding_protocol = "MatchRequest"
  forwarding_configuration {
    frontend_endpoint_name = azurerm_frontdoor_frontend_endpoint.frontend_endpoint.name
    backend_pool_name      = azurerm_frontdoor_backend_pool.backend_pool.name
  }
}

# Configurar o Azure Application Gateway
resource "azurerm_application_gateway" "app_gateway" {
  name                = "MyAppGateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }
}

resource "azurerm_application_gateway_backend_address_pool" "app_gateway_backend_pool" {
  name                = "MyAppGatewayBackendPool"
  resource_group_name = azurerm_resource_group.rg.name
  application_gateway_name = azurerm_application_gateway.app_gateway.name
}

resource "azurerm_application_gateway_backend_http_settings" "app_gateway_backend_http_settings" {
  name                  = "MyAppGatewayBackendHttpSettings"
  resource_group_name   = azurerm_resource_group.rg.name
  cookie_based_affinity = "Disabled"
  path                  = "/"
  port                  = 443
  protocol              = "Https"
  pick_host_name_from_backend_http_settings = true
  request_timeout       = 20
  probe_name            = azurerm_application_gateway_probe.app_gateway_probe.name
}

resource "azurerm_application_gateway_probe" "app_gateway_probe" {
  name                = "MyAppGatewayProbe"
  resource_group_name = azurerm_resource_group.rg.name
  application_gateway_name = azurerm_application_gateway.app_gateway.name
  protocol            = "Https"
  host                = "example.com" # Substitua pelo domínio do seu website
  path                = "/"
  interval            = 30
  timeout             = 30
  unhealthy_threshold = 3
}

resource "azurerm_application_gateway_http_listener" "app_gateway_http_listener" {
  name                  = "MyAppGatewayHttpListener"
  resource_group_name   = azurerm_resource_group.rg.name
  application_gateway_name = azurerm_application_gateway.app_gateway.name
  frontend_ip_configuration_name = azurerm_application_gateway.app_gateway.frontend_ip_configuration[0].name
  frontend_port_name    = azurerm_application_gateway.app_gateway.frontend_port[0].name
  protocol              = "Https"
  host_name             = "example.com" # Substitua pelo domínio do seu website
  require_sni           = true
}

resource "azurerm_application_gateway_request_routing_rule" "app_gateway_routing_rule" {
  name                  = "MyAppGatewayRoutingRule"
  resource_group_name   = azurerm_resource_group.rg.name
  application_gateway_name = azurerm_application_gateway.app_gateway.name
  rule_type             = "Basic"
  http_listener_name    = azurerm_application_gateway_http_listener.app_gateway_http_listener.name
  backend_address_pool_name = azurerm_application_gateway_backend_address_pool.app_gateway_backend_pool.name
  backend_http_settings_name = azurerm_application_gateway_backend_http_settings.app_gateway_backend_http_settings.name
}

# Configurar o Azure Web Application Firewall (WAF)
resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = "MyWAFPolicy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  policy_settings {
    enabled               = true
    mode                  = "Prevention"
    request_body_check    = true
    max_request_body_size_in_kb = 128
    file_upload_limit_in_mb = 100
    stateful_configuration = true
  }
}

resource "azurerm_web_application_firewall_association" "waf_association" {
  name                = "MyWAFAssociation"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  policy_id            = azurerm_web_application_firewall_policy.waf_policy.id
  target_id            = azurerm_application_gateway.app_gateway.id
}

# Configurar o Azure DDoS Protection
resource "azurerm_ddos_protection_plan" "ddos_plan" {
  name                = "MyDDOSPlan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  virtual_network_ids = [azurerm_virtual_network.vnet.id]
}

resource "azurerm_network_interface" "nic" {
  name                = "MyNIC"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "MyNICConfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "MyPublicIP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  ddos_protection_plan_id = azurerm_ddos_protection_plan.ddos_plan.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "MyNSG"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "MyVNet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "MySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  ddos_protection_plan_id = azurerm_ddos_protection_plan.ddos_plan.id
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip_network_interface_association" "public_ip_nic_association" {
  public_ip_address_id = azurerm_public_ip.public_ip.id
  network_interface_id = azurerm_network_interface.nic.id
}

# Configurar o Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = "MyKeyVault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "key_vault_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_app_service.app_service.identity[0].principal_id
    secret_permissions = [
      "get",
      "list"
    ]
    key_permissions = [
      "get",
      "list"
    ]
  }
}

# Obter credenciais do Azure Key Vault
data "azurerm_key_vault_secret" "db_credentials" {
  name         = "DatabaseCredentials"
  key_vault_id = azurerm_key_vault.key_vault.id
}

# Configurar o Azure Log Analytics e Azure Monitor (opcional, somente se desejar monitoramento e logs)
resource "azurerm_log_analytics_workspace" "law" {
  name                = "MyLogAnalyticsWorkspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
  retention_in_days   = 365 # Substitua pelo período de retenção desejado
}

# Outras configurações, como configuração de métricas e logs, podem ser adicionadas aqui.

# Adicione aqui as saídas que deseja expor, como URLs de aplicativos, endpoints e outros detalhes relevantes.

