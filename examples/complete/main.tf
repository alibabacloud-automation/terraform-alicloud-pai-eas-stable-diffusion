# Configure Alibaba Cloud Provider
provider "alicloud" {
  region = "ap-southeast-1" # Default region for example
}

# Call the PAI-EAS module
module "pai_eas" {
  source = "../../"

  vpc_config = {
    vpc_name   = "pai-eas-example-vpc"
    cidr_block = "192.168.0.0/16"
  }

  vswitch_config = {
    vswitch_name = "pai-eas-example-vswitch"
    cidr_block   = "192.168.0.0/18"
    zone_id      = "ap-southeast-1c"
  }

  pai_service_config = {
    service_name  = "sdwebui_example"
    instance_type = "ecs.gn6i-c16g1.4xlarge"
  }
}