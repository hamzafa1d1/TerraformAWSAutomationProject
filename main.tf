provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  # Set var.ami_free_tier_only=false if this returns 0 AMIs in your region/account.
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

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  root_block_device {
    volume_size = var.root_volume_size_gb
    volume_type = var.root_volume_type
  }

  # Only meaningful for burstable instances (t3/t4g). Safe default.
  credit_specification {
    cpu_credits = var.cpu_credits
  }

  tags = merge(
    var.tags,
    { Name = var.instance_name }
  )
}
