module "ovf-deploy" {
  source = "../.."

  datacenter        = "Core"
  cluster           = "Management"
  primary_datastore = "hl-core-ds02"

  // OVF deploy needs you to specify a host to deploy to.
  hosts = [
    "hlcoresx01.humblelab.com"
  ]

  // You will need to know the "source" network defined on the OVF, and the name of the target network you want to connect that to.
  ovf_network_map = {
    "VM-Network-DVPG" : "Common"
    "second-net" : "VM Network"
  }

  // Here we reuse the "networks" variable that is used during VM cloning. Set the address/netmask value for your first network here. If you need to assign additional network addresses, you will need to do that in the vapp_properties map below.
  networks = {
    "Common" : "10.0.0.34/24"
    "VM Network" : "dhcp"
  }

  // This example has the remote_url as an internal artifactory server. You could also use local_ovf_path
  remote_ovf_url = "http://artifactory.humblelab.com:8081/artifactory/esxi-67/Nested_ESXi6.7_Appliance_Template_v1.ova"

  // You can add extra vapp_properties here, and they will be merged with the property set allocated in the module.
  vapp_properties = {
    "guestinfo.createvmfs" = "true"
  }

  // Here we reuse the dns_server_list variable from the cloning workflow. The module converts the list to a comma separated string.
  dns_server_list = [
    "192.168.1.5",
    "8.8.8.8"
  ]
  gateway        = "10.0.0.1"
  domain         = "humblelab.com"
  ovf_enable_ssh = "true"
}
