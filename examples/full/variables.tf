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

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to assign to the VPC"
}

variable "public_subnet_cidr" {
  type = object({
    cidr     = string
    az_index = number
  })
  description = "Object reprisenting the public subnet CIDR and its availability zone. The az_index property is used as an index to retireve a zone from the list of the availability zones for the current AWS region."
}

# EC2 instance

variable "ami_id" {
  description = "The Id of an Ubuntu ami."
  type        = string
}

variable "key_name" {
  description = "The name of the AWS key pair to use."
  type        = string
}

# GitLab

variable "gitlab_url" {
  description = "The full url of the GitLab instance. Must include the prtocol schema e.i. https:// or http://"
  type        = string
  validation {
    condition     = var.gitlab_url == "" || can(regex("^http(s)*://.*$", var.gitlab_url))
    error_message = "The 'gitlab_url' value must statrt with the protocol scheme e.i. https:// or http:// ."
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
