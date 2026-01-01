module "rg" {
  source = "../Enviorment/dev/azurerm_resource_group"
  rgs    = var.rgmodule
}
