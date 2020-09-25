module "gitlab" {
  source = "git::https://github.com/slavrd/terraform-aws-gitlab-ce.git"

  # change values to match your infrastructure
  name_prefix                 = var.name_prefix
  vpc_id                      = module.gl_network.vpc_id
  subnet_id                   = module.gl_network.public_subnet_ids[0]
  associate_public_ip_address = true
  ami_id                      = var.ami_id
  key_name                    = var.key_name
  gitlab_url                  = var.gitlab_url
  gitlab_letsencrypt_enable   = var.gitlab_letsencrypt_enable
  gitlab_version              = var.gitlab_version

  common_tags = var.common_tags

  # make sure module is deployed only after all network resources are created
  depends_on = [
    module.gl_network,
    aws_route53_record.gl
  ]
}