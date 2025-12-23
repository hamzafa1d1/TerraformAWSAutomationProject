locals {
  tags = merge(var.tags, {
    Module = "compute_ec2"
  })
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  # Set ami_free_tier_only=false if this returns 0 AMIs in your region/account.
  dynamic "filter" {
    for_each = var.ami_free_tier_only ? [1] : []
    content {
      name   = "free-tier-eligible"
      values = ["true"]
    }
  }

  filter {
    name   = "architecture"
    values = [var.ami_architecture]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }
}

resource "aws_security_group" "instance" {
  name        = "${var.name_prefix}-ec2-sg"
  description = "Security group for ${var.name_prefix} EC2"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = length(var.ssh_ingress_cidr_blocks) > 0 ? [1] : []
    content {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_ingress_cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.enable_http ? [1] : []
    content {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.http_ingress_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.name_prefix}-ec2-sg"
  })
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.instance.id]
  associate_public_ip_address = var.associate_public_ip_address

  user_data = var.user_data

  root_block_device {
    volume_size = var.root_volume_size_gb
    volume_type = var.root_volume_type
  }

  # Only meaningful for burstable instances (t3/t4g). Safe default.
  credit_specification {
    cpu_credits = var.cpu_credits
  }

  tags = merge(local.tags, {
    Name = "${var.name_prefix}-ec2"
  })
}
