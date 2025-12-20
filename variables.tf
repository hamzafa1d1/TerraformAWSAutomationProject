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

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
  default     = "t3.micro"
}

variable "instance_name" {
  type        = string
  description = "Value for the Name tag."
  default     = "learn-terraform"
}

variable "root_volume_size_gb" {
  type        = number
  description = "Root EBS volume size in GB."
  default     = 8
}

variable "root_volume_type" {
  type        = string
  description = "Root EBS volume type."
  default     = "gp3"
}

variable "cpu_credits" {
  type        = string
  description = "CPU credits setting for burstable instances (standard or unlimited)."
  default     = "standard"

  validation {
    condition     = contains(["standard", "unlimited"], var.cpu_credits)
    error_message = "cpu_credits must be 'standard' or 'unlimited'."
  }
}

# AMI selection variables
variable "ami_owners" {
  type        = list(string)
  description = "AMI owner IDs."
  default     = ["099720109477"] # Canonical
}

variable "ami_name_pattern" {
  type        = string
  description = "AMI name pattern filter."
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "ami_architecture" {
  type        = string
  description = "AMI architecture."
  default     = "x86_64"
}

variable "ami_virtualization_type" {
  type        = string
  description = "AMI virtualization type."
  default     = "hvm"
}

variable "ami_free_tier_only" {
  type        = bool
  description = "If true, filter AMIs to those marked free-tier-eligible."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to apply to resources."
  default     = {}
}
