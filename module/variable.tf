variable "rgmodule" {
  type = map(object({
    resource_group_name = string
    location            = string
  }))
}
