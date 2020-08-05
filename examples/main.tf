module "ovf-deploy" {
  source = "github.com/grantorchard/terraform-vsphere-module-virtual-machine"

  datacenter        = "Core"
  cluster           = "Management"
  primary_datastore = "hl-core-ds02"
  hosts             = [
    "hlcoresx01.humblelab.com"
  ]
  ovf_network_map   = {
    "VM-Network-DVPG":"Common"
  }
  remote_ovf_url    = "http://artifactory.humblelab.com:8081/artifactory/esxi-67/Nested_ESXi6.7_Appliance_Template_v1.ova"
  vapp_properties   = {
    "guestinfo.createvmfs" = "true"
  }
  dns_server_list   = [
    "192.168.1.5",
    "8.8.8.8"
  ]
  gateway           = "10.0.0.1"
  domain            = "humblelab.com"
  ovf_ipaddress     = "10.0.0.34"
  ovf_netmask       = "24"
  ovf_enable_ssh    = "true"
}