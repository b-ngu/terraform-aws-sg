resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = merge(
    { "Name" = "${local.resource_prefix}-sg" },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_self" {
  count = length(var.ingress_rules) > 0 ? 1 : 0

  security_group_id = aws_security_group.this.id

  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  self        = true
  description = "Ingress from self"
}

resource "aws_security_group_rule" "egress_self" {
  count = length(var.egress_rules) > 0 ? 1 : 0

  security_group_id = aws_security_group.this.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  self        = true
  description = "Egress to self"
}
