Alibaba Cloud PAI-EAS Stable Diffusion WebUI Terraform Module

# terraform-alicloud-pai-eas-stable-diffusion

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-pai-eas-stable-diffusion/blob/main/README-CN.md)

Terraform module which creates PAI-EAS service for deploying Stable Diffusion WebUI on Alibaba Cloud. This module implements the solution for [PAI deployment of multi-modal Stable Diffusion WebUI services](https://www.aliyun.com/solution/tech-solution/pai-eas), involving the creation and deployment of resources such as PAI, NAS, NAT Gateway, and other related infrastructure components to provide a complete AI image generation service.

## Usage

This module creates a complete infrastructure for running Stable Diffusion WebUI on PAI-EAS, including VPC network, storage, and compute resources. The deployment is optimized for AI workloads with GPU support and persistent storage.

```terraform
provider "alicloud" {
  region = "ap-southeast-1"
}

module "pai_eas_stable_diffusion" {
  source = "alibabacloud-automation/pai-eas-stable-diffusion/alicloud"

  vpc_config = {
    cidr_block = "192.168.0.0/16"
  }

  vswitch_config = {
    cidr_block = "192.168.0.0/18"
    zone_id    = "ap-southeast-1c"
  }

  pai_service_config = {
    service_name  = "stable-diffusion-webui"
    instance_type = "ecs.gn6i-c16g1.4xlarge"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-pai-eas-stable-diffusion/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_eip.eip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip) | resource |
| [alicloud_eip_association.eip_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_nas_access_group.nas_access_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_group) | resource |
| [alicloud_nas_access_rule.nas_access_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_rule) | resource |
| [alicloud_nas_file_system.nas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [alicloud_nas_mount_target.nas_mount_target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_mount_target) | resource |
| [alicloud_nat_gateway.nat_gateway](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_pai_service.pai_eas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_service) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_snat_entry.snat_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eip_config"></a> [eip\_config](#input\_eip\_config) | Configuration for Elastic IP Address. Note: name is mapped to address\_name in the resource. | <pre>object({<br/>    name                 = optional(string, "pai-eas-eip")<br/>    bandwidth            = optional(number, 200)<br/>    internet_charge_type = optional(string, "PayByTraffic")<br/>  })</pre> | `{}` | no |
| <a name="input_nas_access_group_config"></a> [nas\_access\_group\_config](#input\_nas\_access\_group\_config) | Configuration for NAS Access Group. | <pre>object({<br/>    access_group_type = optional(string, "Vpc")<br/>    access_group_name = optional(string, "pai-eas-nas-access-group")<br/>    file_system_type  = optional(string, "standard")<br/>  })</pre> | `{}` | no |
| <a name="input_nas_access_rule_config"></a> [nas\_access\_rule\_config](#input\_nas\_access\_rule\_config) | Configuration for NAS Access Rule. | <pre>object({<br/>    priority         = optional(number, 100)<br/>    user_access_type = optional(string, "no_squash")<br/>    source_cidr_ip   = optional(string, "0.0.0.0/0")<br/>    rw_access_type   = optional(string, "RDWR")<br/>    file_system_type = optional(string, "standard")<br/>  })</pre> | `{}` | no |
| <a name="input_nas_file_system_config"></a> [nas\_file\_system\_config](#input\_nas\_file\_system\_config) | Configuration for NAS File System. | <pre>object({<br/>    file_system_type = optional(string, "standard")<br/>    storage_type     = optional(string, "Performance")<br/>    protocol_type    = optional(string, "NFS")<br/>    encrypt_type     = optional(number, 0)<br/>  })</pre> | `{}` | no |
| <a name="input_nas_mount_target_config"></a> [nas\_mount\_target\_config](#input\_nas\_mount\_target\_config) | Configuration for NAS Mount Target. | <pre>object({<br/>    status       = optional(string, "Active")<br/>    network_type = optional(string, "Vpc")<br/>  })</pre> | `{}` | no |
| <a name="input_nat_gateway_config"></a> [nat\_gateway\_config](#input\_nat\_gateway\_config) | Configuration for NAT Gateway. Note: instance\_charge\_type is mapped to payment\_type in the resource. | <pre>object({<br/>    nat_gateway_name     = optional(string, "pai-eas-nat-gateway")<br/>    payment_type         = optional(string, "PayAsYouGo")<br/>    internet_charge_type = optional(string, "PayByLcu")<br/>    nat_type             = optional(string, "Enhanced")<br/>    network_type         = optional(string, "internet")<br/>    tags                 = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_pai_service_config"></a> [pai\_service\_config](#input\_pai\_service\_config) | Configuration for PAI-EAS Service. The attributes 'service\_name' and 'instance\_type' are required. | <pre>object({<br/>    service_name      = string<br/>    instance_type     = string<br/>    instance_count    = optional(number, 1)<br/>    cpu               = optional(number, 16)<br/>    gpu               = optional(number, 1)<br/>    memory            = optional(number, 62000)<br/>    type              = optional(string, "SDCluster")<br/>    enable_webservice = optional(string, "true")<br/>    nfs_path          = optional(string, "/")<br/>    resource_type     = optional(string, "model")<br/>    mount_path        = optional(string, "/code/stable-diffusion-webui/data-nas")<br/>    container_image   = optional(string, "eas-registry-vpc.ap-southeast-1.cr.aliyuncs.com/pai-eas/stable-diffusion-webui:4.1")<br/>    container_script  = optional(string, "./webui.sh --listen --port 8000 --skip-version-check --no-hashing --no-download-sd-model --skip-install --api --filebrowser --cluster-status --sd-dynamic-cache --data-dir /code/stable-diffusion-webui/data-nas")<br/>    container_port    = optional(number, 8000)<br/>    meta_type         = optional(string, "SDCluster")<br/>    enable_cache      = optional(bool, true)<br/>    create_timeout    = optional(string, "20m")<br/>  })</pre> | <pre>{<br/>  "instance_type": null,<br/>  "service_name": null<br/>}</pre> | no |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | Configuration for Security Group. | <pre>object({<br/>    security_group_name = optional(string, "pai-eas-security-group")<br/>    security_group_type = optional(string, "normal")<br/>  })</pre> | `{}` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Security group rules configuration. | <pre>map(object({<br/>    type        = string<br/>    ip_protocol = string<br/>    nic_type    = string<br/>    policy      = string<br/>    port_range  = string<br/>    priority    = number<br/>    cidr_ip     = string<br/>  }))</pre> | <pre>{<br/>  "allow_http": {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "80/80",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  },<br/>  "allow_https": {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "443/443",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  }<br/>}</pre> | no |
| <a name="input_snat_entry_config"></a> [snat\_entry\_config](#input\_snat\_entry\_config) | Configuration for SNAT entry. | <pre>object({<br/>    source_cidr = optional(string, "192.168.0.0/18")<br/>  })</pre> | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration for VPC. The attribute 'cidr\_block' is required. | <pre>object({<br/>    vpc_name   = optional(string, "pai-eas-vpc")<br/>    cidr_block = string<br/>  })</pre> | n/a | yes |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | Configuration for VSwitch. The attributes 'cidr\_block' and 'zone\_id' are required. | <pre>object({<br/>    cidr_block   = string<br/>    zone_id      = string<br/>    vswitch_name = optional(string, "pai-eas-vswitch")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip_address"></a> [eip\_address](#output\_eip\_address) | The IP address of the Elastic IP |
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | The ID of the Elastic IP Address |
| <a name="output_nas_access_group_name"></a> [nas\_access\_group\_name](#output\_nas\_access\_group\_name) | The name of the NAS Access Group |
| <a name="output_nas_file_system_id"></a> [nas\_file\_system\_id](#output\_nas\_file\_system\_id) | The ID of the NAS File System |
| <a name="output_nas_mount_target_domain"></a> [nas\_mount\_target\_domain](#output\_nas\_mount\_target\_domain) | The domain name of the NAS Mount Target |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT Gateway |
| <a name="output_nat_gateway_snat_table_ids"></a> [nat\_gateway\_snat\_table\_ids](#output\_nat\_gateway\_snat\_table\_ids) | The SNAT table IDs of the NAT Gateway |
| <a name="output_pai_service_id"></a> [pai\_service\_id](#output\_pai\_service\_id) | The ID of the PAI-EAS Service |
| <a name="output_pai_service_name"></a> [pai\_service\_name](#output\_pai\_service\_name) | The name of the PAI-EAS Service |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#output\_vswitch\_cidr\_block) | The CIDR block of the VSwitch |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)