module "first_vm" {
  source = "../../"

  datacenter        = "Core"
  cluster           = "Management"
  primary_datastore = "hl-core-ds02"
  template          = "consul_sso-srv"
  networks          = {
    "VM Network":"dhcp"
  }
  extra_disks       = [
    {
      "path":vsphere_virtual_disk.this.vmdk_path
      "disk_sharing":"sharingMultiWriter"
      "datastore_id":vsphere_virtual_disk.this.datastore
    }
  ]
}

resource vsphere_virtual_disk "this" {
  size       = 2
  vmdk_path  = "/shared_disk/module.vmdk"
  create_directories = true
  datacenter = "Core"
  datastore  = "hl-core-ds02"
  type       = "eagerZeroedThick"
}