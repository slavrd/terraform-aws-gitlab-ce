output "instance_private_ip" {
  description = "The private IP of the EC2 instance."
  value       = aws_instance.gitlab.private_ip
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = try(data.aws_eip.external_eip[0].public_ip, aws_instance.gitlab.public_ip)
}

output "instance_public_dns" {
  description = "The public DNS of the EC2 instance."
  value       = try(data.aws_eip.external_eip[0].public_dns, aws_instance.gitlab.public_dns)
}

output "gitlab_url" {
  description = "The URL of the GitLab instance."
  value       = coalesce(var.gitlab_url, "http://${try(data.aws_eip.external_eip[0].public_dns, aws_instance.gitlab.public_dns, aws_instance.gitlab.private_dns)}")
}