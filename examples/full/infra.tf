module "gl_network" {
  source = "git::https://github.com/slavrd/terraform-aws-basic-network.git?ref=0.4.0"

  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidrs = [var.public_subnet_cidr]
  name_prefix         = var.name_prefix
  common_tags         = var.common_tags
}

resource "aws_eip" "gl_public" {
  vpc  = true
  tags = var.common_tags
}

locals {
  gitlab_hostname = trim(split("://", var.gitlab_url)[1], "/")
}

data "aws_route53_zone" "gl" {
  name = "${join(".", slice(split(".", local.gitlab_hostname), 1, length(split(".", local.gitlab_hostname))))}."
}

resource "aws_route53_record" "gl" {
  zone_id         = data.aws_route53_zone.gl.id
  name            = trim(split("://", var.gitlab_url)[1], "/")
  type            = "A"
  ttl             = 30
  allow_overwrite = true
  records         = [aws_eip.gl_public.public_ip]
}