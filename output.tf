output "instance_private_ip" {
  description = ""
  value       = aws_instance.gitlab.private_ip
}

output "instance_public_ip" {
  description = ""
  value       = try(data.aws_eip.external_eip[0].public_ip, aws_instance.gitlab.public_ip)
}

output "instance_public_dns" {
  description = ""
  value       = try(data.aws_eip.external_eip[0].public_dns, aws_instance.gitlab.public_dns)
}