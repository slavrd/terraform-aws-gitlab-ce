# Genral

variable "name_prefix" {
  description = "Prefix to be used in the names of the managed resources."
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Tags to attach to the managed resources."
  type        = map(string)
  default     = {}
}

# Network

variable "vpc_id" {
  description = "The Id of the VPC in which to deploy the resources."
  type        = string
}

variable "subnet_id" {
  description = "The subnet in which to deploy the resources."
  type        = string
}

variable "ingress_cidrs_http" {
  description = "List of CIDRs to allow http traffic from."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ingress_cidrs_ssh" {
  description = "List of CIDRs to allow ssh traffic from."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 instance

variable "ami_id" {
  description = "The Id of an Ubuntu ami."
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance."
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "The name of the AWS key pair to use."
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = true
}

variable "root_block_device_size" {
  description = "The size of the root block device of the EC2 instance."
  type        = number
  default     = 50
}

# GitLab

variable "gitlab_url" {
  description = "The full url of the GitLab instance. Must include the protocol schema e.i. https:// or http://"
  type        = string
  validation {
    condition     = var.gitlab_url == "" || can(regex("^http(s)*://.*$", var.gitlab_url))
    error_message = "The 'gitlab_url' value must statrt with the protocol scheme e.i. https:// or http:// . If no URL is provided the EC2 instance url will be used."
  }
  default = ""
}

variable "gitlab_letsencrypt_enable" {
  description = "Whether to enable letsencrypt to auto genereate SSL certificates."
  type        = bool
  default     = false
}

variable "gitlab_version" {
  description = "GitLab version to install. If the provided string matches several versions the latest one will be isntalled. If the string does not match any version - the latest GitLab version will be installed."
  type        = string
  default     = ""
}
