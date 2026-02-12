# VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_config.vpc_name
  cidr_block = var.vpc_config.cidr_block
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_config.cidr_block
  zone_id      = var.vswitch_config.zone_id
  vswitch_name = var.vswitch_config.vswitch_name
}

# NAT Gateway
resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id               = alicloud_vpc.vpc.id
  vswitch_id           = alicloud_vswitch.vswitch.id
  nat_gateway_name     = var.nat_gateway_config.nat_gateway_name
  payment_type         = var.nat_gateway_config.payment_type
  internet_charge_type = var.nat_gateway_config.internet_charge_type
  nat_type             = var.nat_gateway_config.nat_type
  network_type         = var.nat_gateway_config.network_type

  tags = var.nat_gateway_config.tags
}

# EIP
resource "alicloud_eip" "eip" {
  address_name         = var.eip_config.name
  bandwidth            = var.eip_config.bandwidth
  internet_charge_type = var.eip_config.internet_charge_type
}

# EIP Association to NAT Gateway
resource "alicloud_eip_association" "eip_association" {
  allocation_id = alicloud_eip.eip.id
  instance_id   = alicloud_nat_gateway.nat_gateway.id
}

# SNAT Entry
resource "alicloud_snat_entry" "snat_entry" {
  snat_table_id = alicloud_nat_gateway.nat_gateway.snat_table_ids
  snat_ip       = alicloud_eip.eip.ip_address
  source_cidr   = var.snat_entry_config.source_cidr

  depends_on = [alicloud_eip_association.eip_association]
}

# Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_config.security_group_name
  security_group_type = var.security_group_config.security_group_type
}

# Security Group Rules
resource "alicloud_security_group_rule" "security_group_rules" {
  for_each = var.security_group_rules

  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = each.value.cidr_ip
}

# NAS File System
resource "alicloud_nas_file_system" "nas" {
  file_system_type = var.nas_file_system_config.file_system_type
  storage_type     = var.nas_file_system_config.storage_type
  protocol_type    = var.nas_file_system_config.protocol_type
  encrypt_type     = var.nas_file_system_config.encrypt_type
}

# NAS Access Group
resource "alicloud_nas_access_group" "nas_access_group" {
  access_group_type = var.nas_access_group_config.access_group_type
  access_group_name = var.nas_access_group_config.access_group_name
  file_system_type  = var.nas_access_group_config.file_system_type
}

# NAS Access Rule
resource "alicloud_nas_access_rule" "nas_access_rule" {
  priority          = var.nas_access_rule_config.priority
  user_access_type  = var.nas_access_rule_config.user_access_type
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
  source_cidr_ip    = var.nas_access_rule_config.source_cidr_ip
  rw_access_type    = var.nas_access_rule_config.rw_access_type
  file_system_type  = var.nas_access_rule_config.file_system_type
}

# NAS Mount Target
resource "alicloud_nas_mount_target" "nas_mount_target" {
  vpc_id            = alicloud_vpc.vpc.id
  vswitch_id        = alicloud_vswitch.vswitch.id
  security_group_id = alicloud_security_group.security_group.id
  status            = var.nas_mount_target_config.status
  file_system_id    = alicloud_nas_file_system.nas.id
  network_type      = var.nas_mount_target_config.network_type
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name

  depends_on = [alicloud_nas_access_rule.nas_access_rule]
}

# PAI-EAS Service
resource "alicloud_pai_service" "pai_eas" {
  service_config = jsonencode({
    metadata = {
      name              = var.pai_service_config.service_name
      instance          = var.pai_service_config.instance_count
      cpu               = var.pai_service_config.cpu
      gpu               = var.pai_service_config.gpu
      memory            = var.pai_service_config.memory
      type              = var.pai_service_config.type
      enable_webservice = var.pai_service_config.enable_webservice
    }
    cloud = {
      computing = {
        instance_type = var.pai_service_config.instance_type
      }
      networking = {
        vpc_id            = alicloud_vpc.vpc.id
        vswitch_id        = alicloud_vswitch.vswitch.id
        security_group_id = alicloud_security_group.security_group.id
      }
    }
    storage = [
      {
        nfs = {
          path   = var.pai_service_config.nfs_path
          server = alicloud_nas_mount_target.nas_mount_target.mount_target_domain
        }
        properties = {
          resource_type = var.pai_service_config.resource_type
        }
        mount_path = var.pai_service_config.mount_path
      }
    ]
    containers = [
      {
        image  = var.pai_service_config.container_image
        script = var.pai_service_config.container_script
        port   = var.pai_service_config.container_port
      }
    ]
    meta = {
      type = var.pai_service_config.meta_type
    }
    options = {
      enableCache = var.pai_service_config.enable_cache
    }
  })

  timeouts {
    create = var.pai_service_config.create_timeout
  }
}