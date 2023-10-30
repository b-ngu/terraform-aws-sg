provider "aws" {
  region = var.region
}

module "security_group" {
  source = "../../"  # Update this path to the location of your module

  contact     = var.contact
  environment = var.environment
  team        = var.team
  purpose     = var.purpose

  vpc_id = "vpc-abcdefgh"  # Replace this with your VPC ID

  name        = "my-security-group"
  description = "Security group managed by Terraform"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    "Environment" = "Dev"
    "Team"        = "devops"
  }
}