data vsphere_compute_cluster "this" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_datacenter "this" {
  name = var.datacenter
}

data vsphere_datastore "this" {
  for_each      = var.primary_datastore != "" ? toset([var.primary_datastore]) : toset([])
  name          = each.value
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_datastore_cluster "this" {
  for_each      = var.primary_datastore_cluster != "" ? toset([var.primary_datastore_cluster]) : toset([])
  name          = each.value
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_host "this" {
  for_each      = toset(var.hosts)
  name          = each.value
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_network "this" {
  for_each      = toset(keys(var.networks))
  name          = each.key
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_resource_pool "this" {
  for_each      = var.resource_pool != "" ? toset([var.resource_pool]) : toset([])
  name          = each.value
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_storage_policy "this" {
  for_each = toset(var.storage_policies)
  name     = each.value
}

data vsphere_tag "this" {
  for_each    = toset(var.tags)
  name        = each.value["name"]
  category_id = each.value["category_id"]
}

data vsphere_tag_category "this" {
  for_each = toset(var.tag_categories)
  name     = each.value
}

data vsphere_virtual_machine "this" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_vmfs_disks "this" {
  for_each       = toset(var.disks)
  host_system_id = each.value["host_id"]
  rescan         = true
  filter         = each.value["filter"]
}