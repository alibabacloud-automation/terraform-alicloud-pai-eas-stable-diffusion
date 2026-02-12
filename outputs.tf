output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch"
  value       = alicloud_vswitch.vswitch.cidr_block
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = alicloud_nat_gateway.nat_gateway.id
}

output "nat_gateway_snat_table_ids" {
  description = "The SNAT table IDs of the NAT Gateway"
  value       = alicloud_nat_gateway.nat_gateway.snat_table_ids
}

output "eip_id" {
  description = "The ID of the Elastic IP Address"
  value       = alicloud_eip.eip.id
}

output "eip_address" {
  description = "The IP address of the Elastic IP"
  value       = alicloud_eip.eip.ip_address
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = alicloud_security_group.security_group.id
}

output "nas_file_system_id" {
  description = "The ID of the NAS File System"
  value       = alicloud_nas_file_system.nas.id
}

output "nas_access_group_name" {
  description = "The name of the NAS Access Group"
  value       = alicloud_nas_access_group.nas_access_group.access_group_name
}

output "nas_mount_target_domain" {
  description = "The domain name of the NAS Mount Target"
  value       = alicloud_nas_mount_target.nas_mount_target.mount_target_domain
}

output "pai_service_id" {
  description = "The ID of the PAI-EAS Service"
  value       = alicloud_pai_service.pai_eas.id
}

output "pai_service_name" {
  description = "The name of the PAI-EAS Service"
  value       = var.pai_service_config.service_name
}