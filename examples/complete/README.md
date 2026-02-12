# Complete Example

This example demonstrates how to use the PAI-EAS module to deploy a complete Stable Diffusion WebUI service on Alibaba Cloud.

## What This Example Creates

- VPC and VSwitch for network isolation
- NAT Gateway with EIP for internet access
- Security Group with HTTP/HTTPS rules
- NAS file system for persistent storage
- PAI-EAS service running Stable Diffusion WebUI

## Prerequisites

- Alibaba Cloud account with appropriate permissions
- Terraform >= 1.0
- Access to GPU instances (ecs.gn6i family recommended)

## Usage

1. Clone or download this example
2. Set your Alibaba Cloud credentials:
   ```bash
   export ALICLOUD_ACCESS_KEY="your-access-key"
   export ALICLOUD_SECRET_KEY="your-secret-key"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review and modify variables if needed:
   ```bash
   terraform plan
   ```

5. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

## Configuration

The example uses default values for most configurations. You can customize the deployment by modifying the module parameters in `main.tf`.

### Key Configuration Options

- **Region**: Set via the `region` variable (default: ap-southeast-1)
- **VPC CIDR**: 192.168.0.0/16
- **VSwitch CIDR**: 192.168.0.0/18
- **Instance Type**: Automatically selected from available GPU instances

### GPU Instance Requirements

The PAI-EAS service requires GPU instances. The example automatically selects available GPU instances from the ecs.gn6i family. Ensure your account has quota for GPU instances in the selected region.

## Outputs

After successful deployment, you'll get:

- VPC and VSwitch IDs
- EIP address for internet access
- PAI service ID and name
- NAS mount target domain

## Accessing the Service

Once deployed, the Stable Diffusion WebUI will be accessible through the PAI-EAS service endpoint. Check the Alibaba Cloud console for the service URL.

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

## Notes

- The deployment may take 15-20 minutes due to PAI service initialization
- Ensure you have sufficient quota for GPU instances in your selected region
- The NAS file system provides persistent storage for models and generated images