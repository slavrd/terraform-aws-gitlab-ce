output "instance_private_ip" {
  description = ""
  value       = aws_instance.gitlab.private_ip
}

output "instance_public_ip" {
  description = ""
  value       = aws_instance.gitlab.public_ip
}