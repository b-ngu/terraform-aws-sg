# terraform-aws-security-group

## Summary

Terraform module which creates AWS Security Group resources with support for defining ingress and egress rules.

This module is designed for ease of use and flexibility, allowing users to quickly create and manage AWS Security Groups and their associated rules. Security Groups act as a virtual firewall for your instances to control inbound and outbound traffic.

## Helpful AWS Documentation Links

- [What is Amazon VPC?](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [Amazon VPC Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [Security Group Rules](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#BestPractices)

## Example Usage

```hcl
module "security_group" {
  source = "path_to_this_module"

  name        = "my-security-group"
  description = "Security group for my application"
  vpc_id      = "vpc-0123456789abcdef0"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["1.2.3.4/32"]
      description = "SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
  ]

  tags = {
    Environment = "production"
    Application = "my-app"
  }
}
```

Replace `path_to_this_module` with the path to where you have this module.

## Tags

To configure any additional tags, set tags map in module definition

```hcl

module "security_group" {
  source = "path_to_this_module"

  ...

  tags = {
    Owner       = "team-name"
    Environment = "development"
  }
}

```

## Examples

* [SG](./examples/sg)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.28 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.28 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input_region) | The default region for the test. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_contact"></a> [contact](#input_contact) | (Required) The contact for this resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where this resource will live. | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input_team) | (Required) The team responsible for this resource. | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input_purpose) | (Required) The purpose for this resource. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id) | The ID of the VPC where the security group will be created | `string` | n/a | yes |
| <a name="input_ingress_rules"></a> [ingress_rules](#input_ingress_rules) | A list of maps containing the ingress rules for the security group | `list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = string }))` | `[]` | no |
| <a name="input_egress_rules"></a> [egress_rules](#input_egress_rules) | A list of maps containing the egress rules for the security group | `list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = string }))` | `[]` | no |
| <a name="input_name"></a> [name](#input_name) | The name of the security group | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input_description) | The description of the security group | `string` | `"Managed by Terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security_group_id](#output_security_group_id) | The ID of the security group |
| <a name="output_security_group_arn"></a> [security_group_arn](#output_security_group_arn) | The ARN of the security group |
| <a name="output_security_group_name"></a> [security_group_name](#output_security_group_name) | The name of the security group |

<!-- END_TF_DOCS -->