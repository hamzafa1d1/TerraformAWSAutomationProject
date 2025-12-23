output "vpc_id" {
  description = "VPC ID."
  value       = module.network.vpc_id
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "EC2 public IPv4."
  value       = module.compute.instance_public_ip
}

output "bucket_name" {
  description = "S3 bucket name."
  value       = module.storage.bucket_name
}
