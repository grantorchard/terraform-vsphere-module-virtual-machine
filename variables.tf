variable cluster {
  description = "The name of the cluster into which you want your workload provisioned. Must be set if resource_pool is not set."
  type        = string
  default     = ""
}

variable content_library_name {
  type = string
  default = ""
}

variable custom_attributes {
  description = "A list of custom attributes to assign to your vm."
  type        = list(string)
  default     = []
}

variable datacenter {
  description = "The name of the datacenter in which you want your workload provisioned."
  type = string
}

variable primary_datastore {
  description = "The name of the datastore for the first disk to be placed. Must be set if primary_datastore_cluster is not used."
  type    = string
  default = ""
}

variable primary_datastore_cluster {
  description = "The name of the datastore for the first disk to be placed. Must be set if primary_datastore is not used."
  type    = string
  default = ""
}

variable disks {
  description = ""
  type    = list(map(string))
  default = []
}

variable hosts {
  type    = list(string)
  default = []
}

variable resource_pool {
  description = "The name of the resource pool that you want your virtual machine deployed into. If not set, your machine will be placed in the default resource pool of the cluster."
  type    = string
  default = ""
}

variable storage_policies {
  type    = list(string)
  default = []
}

variable tags {
  type    = list(map(string))
  default = []
}

variable tag_categories {
  type    = list(string)
  default = []
}

variable template {
  type    = string
  default = ""
}

variable hostname {
  type    = string
  default = ""
}

variable num_cpus {
  type    = number
  default = 2
}

variable memory {
  type    = number
  default = 2048
}

variable scsi_type {
  type    = string
  default = "pvscsi"
}

variable network_adapter_type {
  type    = string
  default = "vmxnet3"
}

variable eagerly_scrub {
  default = false
}

variable thin_provisioned {
  default = true
}

variable domain {
  type    = string
  default = ""
}

variable gateway {
  type    = string
  default = ""
}

variable networks {
  type = map(string)
  default = {}
}

variable dns_server_list {
  default = []
}

variable dns_suffix_list {
  default = []
}

variable admin_password {
  type = string
  default = ""
}

variable workgroup {
  type = string
  default = ""
}

variable ad_domain {
  type = string
  default = ""
}

variable domain_admin_user {
  type = string
  default = ""
}

variable domain_admin_password {
  type = string
  default = ""
}

variable local_ovf_path {
  type = string
  default = ""
}
variable remote_ovf_url {
  type = string
  default = ""
}
variable ip_allocation_policy {
  type = string
  default = "STATIC_MANUAL"
}
variable ip_protocol {
  type = string
  default = "IPV4"
}
variable disk_provisioning {
  type = string
  default = "thin"
}
variable ovf_network_map {
  type = map
  default = {}
}

variable allow_unverified_ssl_cert {
  type = bool
  default = true
}

variable vapp_properties {
  type = map
  default = {}
}

variable ovf_ipaddress {
  type = string
  default = ""
}
variable ovf_netmask {
  type = string
  default = ""
}
variable ovf_ntp_servers {
  type = list
  default = ["pool.ntp.org"]
}
variable ovf_password {
  type = string
  default = "VMware123!"
}
variable ovf_enable_ssh {
  type = string
  default = "false"
}
variable ovf_syslog_server {
  type = string
  default = ""
}