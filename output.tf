output "instance_private_ip" {
  description = "The private IP of the EC2 instance."
  value       = aws_instance.gitlab.private_ip
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = aws_instance.gitlab.public_ip
}

output "instance_id" {
  description = "The Id of the GitLab instance."
  value       = aws_instance.gitlab.id
}

output "instance_interface_id" {
  description = "The Id of the GitLab instance network interface."
  value       = aws_instance.gitlab.primary_network_interface_id
}

output "instance_public_dns" {
  description = "The public DNS of the EC2 instance."
  value       = aws_instance.gitlab.public_dns
}

output "gitlab_url" {
  description = "The URL of the GitLab instance."
  value       = coalesce(var.gitlab_url, "http://${coalesce(aws_instance.gitlab.public_dns, aws_instance.gitlab.private_dns)}")
}
