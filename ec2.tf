resource "aws_instance" "gitlab" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.gitlab_instance.id]

  # if external eip allocation id is provided  there is no need to associate additional public IP address
  associate_public_ip_address = var.eip_allocation_id == "" ? var.associate_public_ip_address : null

  root_block_device {
    volume_size = var.root_block_device_size
  }

  user_data_base64 = base64encode(templatefile("${path.module}/templates/cloud-init.tmpl", {
    gl_install_gzb64content = base64gzip(templatefile("${path.module}/templates/gl-install.sh.tmpl", {
      gitlab_version = replace(var.gitlab_version, ".", "\\.")
    }))
    gl_config_gzb64content = base64gzip(templatefile("${path.module}/templates/gl-config.sh.tmpl", {
      gitlab_url        = var.gitlab_url
      letsencryt_enable = var.gitlab_letsencrypt_enable
    }))
  }))

  tags = merge(
    { "Name" = "${var.name_prefix}gitlab" },
    var.common_tags
  )
}

resource "aws_eip_association" "gitlab_instance" {
  count         = var.eip_allocation_id == "" ? 0 : 1
  instance_id   = aws_instance.gitlab.id
  allocation_id = var.eip_allocation_id
}

data "aws_eip" "external_eip" {
  count = var.eip_allocation_id == "" ? 0 : 1
  id    = var.eip_allocation_id
}