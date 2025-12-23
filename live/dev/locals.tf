locals {
  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
  })

  # Portable AZ selection (avoids hard-coding us-east-1a, etc.).
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  # Derive subnet CIDRs from vpc_cidr to avoid manually listing them.
  # newbits=8 turns /16 into /24 subnets.
  public_subnet_cidrs  = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i)]
  private_subnet_cidrs = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i + 10)]

  raw_bucket_name     = lower(replace(replace("${local.name_prefix}-${data.aws_caller_identity.current.account_id}-${var.aws_region}", "_", "-"), ".", "-"))
  default_bucket_name = substr(local.raw_bucket_name, 0, 63)
  bucket_name         = coalesce(var.s3_bucket_name, local.default_bucket_name)

  nginx_user_data = var.enable_http ? (<<-EOT
    #!/bin/bash
    set -euo pipefail
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOT
  ) : null
}
