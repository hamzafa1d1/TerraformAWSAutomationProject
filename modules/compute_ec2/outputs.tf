output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.this.id
}

output "instance_private_ip" {
  description = "Private IPv4 address."
  value       = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Public IPv4 address (if associated)."
  value       = aws_instance.this.public_ip
}

output "instance_private_dns" {
  description = "Private DNS name."
  value       = aws_instance.this.private_dns
}

output "security_group_id" {
  description = "Security group ID."
  value       = aws_security_group.instance.id
}

output "ami_id" {
  description = "Selected AMI ID."
  value       = data.aws_ami.ubuntu.id
}
