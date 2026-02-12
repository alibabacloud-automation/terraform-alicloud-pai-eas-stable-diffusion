output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.pai_eas.vpc_id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.pai_eas.vswitch_id
}

output "eip_address" {
  description = "The IP address of the Elastic IP"
  value       = module.pai_eas.eip_address
}

output "pai_service_id" {
  description = "The ID of the PAI-EAS Service"
  value       = module.pai_eas.pai_service_id
}

output "pai_service_name" {
  description = "The name of the PAI-EAS Service"
  value       = module.pai_eas.pai_service_name
}

output "nas_mount_target_domain" {
  description = "The domain name of the NAS Mount Target"
  value       = module.pai_eas.nas_mount_target_domain
}