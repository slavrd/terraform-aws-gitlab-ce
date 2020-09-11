output "gitlab_url" {
  description = "The URL of the GitLab instance."
  value       = module.gitlab.gitlab_url
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = module.gitlab.instance_public_ip
}