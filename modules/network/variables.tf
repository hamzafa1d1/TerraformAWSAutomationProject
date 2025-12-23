variable "name_prefix" {
  type        = string
  description = "Prefix used for naming resources."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "azs" {
  type        = list(string)
  description = "Availability zones to use (e.g. [\"us-east-1a\", \"us-east-1b\"])."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the public subnets (same length/order as azs)."

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.azs)
    error_message = "public_subnet_cidrs must have the same length as azs."
  }
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the private subnets (same length/order as azs)."

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.azs)
    error_message = "private_subnet_cidrs must have the same length as azs."
  }
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT Gateway for private subnets outbound access."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources in this module."
  default     = {}
}
