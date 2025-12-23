variable "project_name" {
  type        = string
  description = "Project name used for naming and tagging."
  default     = "learn-terraform"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)."
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy into."
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile name."
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.10.0.0/16"
}

variable "az_count" {
  type        = number
  description = "How many AZs to use (2 is a common default)."
  default     = 2

  validation {
    condition     = var.az_count >= 1 && var.az_count <= 3
    error_message = "az_count must be between 1 and 3."
  }
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to provision a NAT Gateway for private subnets."
  default     = true
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
  default     = "t3.micro"
}

variable "ssh_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to SSH to the instance (e.g. [\"YOUR_PUBLIC_IP/32\"]). Empty list disables SSH ingress."
  default     = []
}

variable "enable_http" {
  type        = bool
  description = "If true, allow HTTP (80) and install nginx via user_data."
  default     = false
}

variable "s3_bucket_name" {
  type        = string
  description = "Optional S3 bucket name override (must be globally unique). If null, a name is derived from account+region."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Extra tags applied via provider default_tags."
  default     = {}
}
