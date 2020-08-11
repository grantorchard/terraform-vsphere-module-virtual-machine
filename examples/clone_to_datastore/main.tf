module "terraform_agent" {
  source = "../../"

  datacenter        = "Core"
  cluster           = "Management"
  primary_datastore = "hl-core-ds02"
  networks          = {
    "VM Network":"dhcp"
  }
  template          = "consul_sso-srv"
}