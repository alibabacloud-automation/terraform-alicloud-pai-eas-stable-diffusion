variable "vpc_config" {
  description = "Configuration for VPC. The attribute 'cidr_block' is required."
  type = object({
    vpc_name   = optional(string, "pai-eas-vpc")
    cidr_block = string
  })
}

variable "vswitch_config" {
  description = "Configuration for VSwitch. The attributes 'cidr_block' and 'zone_id' are required."
  type = object({
    cidr_block   = string
    zone_id      = string
    vswitch_name = optional(string, "pai-eas-vswitch")
  })
}

variable "nat_gateway_config" {
  description = "Configuration for NAT Gateway. Note: instance_charge_type is mapped to payment_type in the resource."
  type = object({
    nat_gateway_name     = optional(string, "pai-eas-nat-gateway")
    payment_type         = optional(string, "PayAsYouGo")
    internet_charge_type = optional(string, "PayByLcu")
    nat_type             = optional(string, "Enhanced")
    network_type         = optional(string, "internet")
    tags                 = optional(map(string), {})
  })
  default = {}
}

variable "eip_config" {
  description = "Configuration for Elastic IP Address. Note: name is mapped to address_name in the resource."
  type = object({
    name                 = optional(string, "pai-eas-eip")
    bandwidth            = optional(number, 200)
    internet_charge_type = optional(string, "PayByTraffic")
  })
  default = {}
}

variable "snat_entry_config" {
  description = "Configuration for SNAT entry."
  type = object({
    source_cidr = optional(string, "192.168.0.0/18")
  })
  default = {}
}

variable "security_group_config" {
  description = "Configuration for Security Group."
  type = object({
    security_group_name = optional(string, "pai-eas-security-group")
    security_group_type = optional(string, "normal")
  })
  default = {}
}

variable "security_group_rules" {
  description = "Security group rules configuration."
  type = map(object({
    type        = string
    ip_protocol = string
    nic_type    = string
    policy      = string
    port_range  = string
    priority    = number
    cidr_ip     = string
  }))
  default = {
    allow_http = {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "80/80"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
    allow_https = {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "443/443"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
  }
}

variable "nas_file_system_config" {
  description = "Configuration for NAS File System."
  type = object({
    file_system_type = optional(string, "standard")
    storage_type     = optional(string, "Performance")
    protocol_type    = optional(string, "NFS")
    encrypt_type     = optional(number, 0)
  })
  default = {}
}

variable "nas_access_group_config" {
  description = "Configuration for NAS Access Group."
  type = object({
    access_group_type = optional(string, "Vpc")
    access_group_name = optional(string, "pai-eas-nas-access-group")
    file_system_type  = optional(string, "standard")
  })
  default = {}
}

variable "nas_access_rule_config" {
  description = "Configuration for NAS Access Rule."
  type = object({
    priority         = optional(number, 100)
    user_access_type = optional(string, "no_squash")
    source_cidr_ip   = optional(string, "0.0.0.0/0")
    rw_access_type   = optional(string, "RDWR")
    file_system_type = optional(string, "standard")
  })
  default = {}
}

variable "nas_mount_target_config" {
  description = "Configuration for NAS Mount Target."
  type = object({
    status       = optional(string, "Active")
    network_type = optional(string, "Vpc")
  })
  default = {}
}

variable "pai_service_config" {
  description = "Configuration for PAI-EAS Service. The attributes 'service_name' and 'instance_type' are required."
  type = object({
    service_name      = string
    instance_type     = string
    instance_count    = optional(number, 1)
    cpu               = optional(number, 16)
    gpu               = optional(number, 1)
    memory            = optional(number, 62000)
    type              = optional(string, "SDCluster")
    enable_webservice = optional(string, "true")
    nfs_path          = optional(string, "/")
    resource_type     = optional(string, "model")
    mount_path        = optional(string, "/code/stable-diffusion-webui/data-nas")
    container_image   = optional(string, "eas-registry-vpc.ap-southeast-1.cr.aliyuncs.com/pai-eas/stable-diffusion-webui:4.1")
    container_script  = optional(string, "./webui.sh --listen --port 8000 --skip-version-check --no-hashing --no-download-sd-model --skip-install --api --filebrowser --cluster-status --sd-dynamic-cache --data-dir /code/stable-diffusion-webui/data-nas")
    container_port    = optional(number, 8000)
    meta_type         = optional(string, "SDCluster")
    enable_cache      = optional(bool, true)
    create_timeout    = optional(string, "20m")
  })
  default = {
    service_name  = null
    instance_type = null
  }

}