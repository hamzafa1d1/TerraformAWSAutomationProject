variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket (must be globally unique)."
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow Terraform to delete a non-empty bucket."
  default     = true
}

variable "enable_versioning" {
  type        = bool
  description = "Whether to enable S3 bucket versioning."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources in this module."
  default     = {}
}
