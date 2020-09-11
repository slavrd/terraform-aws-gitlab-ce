module "gitlab-basic" {
  source = "../../"

  # change values to match your infrastructure
  name_prefix = "my-gitlab-"
  vpc_id      = "vpc-3302f159"
  subnet_id   = "subnet-cdea0e81"
  ami_id      = "ami-04932daa2567651e7"
  key_name    = "my-aws-key-pair"

  common_tags = {
    terraform = "true"
    project   = "gitlab-example"
  }
}