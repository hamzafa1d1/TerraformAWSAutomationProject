variable "name_prefix" {
  type        = string
  description = "Prefix used for naming resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance will be launched."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
  default     = "t3.micro"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IPv4 address."
  default     = true
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

variable "ssh_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to SSH to the instance. Empty list disables SSH ingress."
  default     = []
}

variable "enable_http" {
  type        = bool
  description = "Whether to allow inbound HTTP (port 80)."
  default     = false
}

variable "http_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to access HTTP."
  default     = ["0.0.0.0/0"]
}

variable "user_data" {
  type        = string
  description = "Optional cloud-init/user-data script."
  default     = null
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
  description = "Tags to apply to resources in this module."
  default     = {}
}
