resource "aws_instance" "gitlab" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.gitlab_instance.id]

  associate_public_ip_address = var.associate_public_ip_address

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
