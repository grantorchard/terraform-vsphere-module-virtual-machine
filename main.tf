locals {
  windows  = length(regexall("^win", data.vsphere_virtual_machine.this.guest_id)) > 0
  hostname = "${random_pet.this.id}-${random_integer.this.result}"
}

resource random_pet "this" {
  length = 2
}

resource random_integer "this" {
  min     = 1000
  max     = 9999
}

resource vsphere_virtual_machine "this" {
  name             = var.hostname != "" ? var.hostname : local.hostname
  resource_pool_id = var.resource_pool != "" ? data.vsphere_resource_pool.this[var.resource_pool].id : data.vsphere_compute_cluster.this.resource_pool_id

  datastore_id         = var.primary_datastore != "" ? data.vsphere_datastore.this[var.primary_datastore].id : null
  datastore_cluster_id = var.primary_datastore_cluster != "" ? data.vsphere_datastore_cluster.this[var.primary_datastore_cluster].id : null

  num_cpus  = var.num_cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.this.guest_id
  scsi_type = data.vsphere_virtual_machine.this.scsi_type

  firmware = data.vsphere_virtual_machine.this.firmware

  dynamic "network_interface" {
    for_each = var.networks
    iterator = network
    content {
      network_id   = data.vsphere_network.this[network.key].id
      adapter_type = var.network_adapter_type
    }
  }

  wait_for_guest_net_timeout = -1

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.this.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.this.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.this.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.this.id

    customize {
      dynamic "linux_options" {
        for_each = local.windows == false ? [0] : []
        content {
          host_name = var.hostname
          domain    = var.domain
        }
      }

      dynamic "windows_options" {
        for_each = local.windows == true ? [0] : []
        content {
          computer_name         = var.hostname
          admin_password        = var.admin_password
          workgroup             = var.workgroup != "" ? var.workgroup : null
          join_domain           = var.ad_domain != "" ? var.ad_domain : null
          domain_admin_user     = var.ad_domain != "" ? var.domain_admin_user : null
          domain_admin_password = var.ad_domain != "" ? var.domain_admin_password : null
        }
      }

      dynamic "network_interface" {
        for_each = var.networks
        iterator = network
        content {
          ipv4_address = lower(network.value) == "dhcp" ? null : split("/", network.value)[0]
          ipv4_netmask = lower(network.value) == "dhcp" ? null : split("/", network.value)[1]
        }
      }

      ipv4_gateway    = var.gateway
      dns_server_list = var.dns_server_list
      dns_suffix_list = var.dns_suffix_list

    }
  }
}