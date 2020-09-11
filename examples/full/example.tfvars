vpc_cidr_block = "172.30.0.0/16"
public_subnet_cidr = {
  cidr     = "172.30.0.0/24"
  az_index = 0
}
name_prefix = "gl-example-"
common_tags = {
  owner   = "me@my.org"
  project = "gl-example"
}
ami_id                    = "ami-0c960b947cbb2dd16"
key_name                  = "my-aws-key-pair-name"
gitlab_url                = "https://gl.example.com"
gitlab_letsencrypt_enable = true
gitlab_version_string     = ""