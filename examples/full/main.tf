module "gitlab" {
  source = "git::https://github.com/slavrd/terraform-aws-gitlab-ce.git?ref=v0.1.0"

  # change values to match your infrastructure
  name_prefix               = var.name_prefix
  vpc_id                    = module.gl_network.vpc_id
  subnet_id                 = module.gl_network.public_subnet_ids[0]
  ami_id                    = var.ami_id
  key_name                  = var.key_name
  eip_allocation_id         = aws_eip.gl_public.id
  gitlab_url                = var.gitlab_url
  gitlab_letsencrypt_enable = var.gitlab_letsencrypt_enable
  gitlab_version_string     = var.gitlab_version_string

  common_tags = var.common_tags

  # make extra sure that dns record is created before GitLab is configured.
  depends_on = [
    aws_route53_record.gl
  ]
}