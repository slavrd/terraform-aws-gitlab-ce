# Terraform AWS GitLab CE

A terraform module to manage a basic GitLab installation in AWS.

The main goal is to enable quick provisioning of a GitLab installation to use for testing.

Upon first installation the GitLab instance will have default user `root` with password `5iveL!fe`.

Depending on the version of GitLab installed you may be asked to first change the password before being able to login for the first time.

## Requirements

* Terraform CLI version `~> 0.13.0`
* Provider `hashicorp/aws` version `~> 3.0`

## Input Variables

The module's input variables are defined in the `variables.tf` file. They are described in the table below.

| Variable | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| name_prefix | `string` | `""` | Prefix to be used in the names of the managed resources. |
| common_tags | `map(string)` | `{}` | Tags to attach to the managed resources. |
| vpc_id | `string` || The Id of the VPC in which to deploy the resources. |
| subnet_id | `string` || The subnet in which to deploy the resources. |
| ingress_cidrs_http | `list(string)` | `["0.0.0.0/0"]` | List of CIDRs to allow http traffic from. |
| ingress_cidrs_ssh | `list(string)` | `["0.0.0.0/0"]` | List of CIDRs to allow ssh traffic from. |
| ami_id | `string` || The Id of an Ubuntu ami. |
| instance_type | `string` | `"t2.medium"` | The type of the EC2 instance. |
| key_name | `string` || The name of the AWS key pair to use. |
| associate_public_ip_address | `bool` | `true` | Whether to associate a public IP address with the instance. |
| root_block_device_size | `number` | `50` | he size of the root block device of the EC2 instance. |
| gitlab_url | `string` | `""` | The full url of the GitLab instance. Must include the protocol schema e.i. https:// or http://". If no URL is provided the EC2 instance url will be used. |
| gitlab_letsencrypt_enable | `bool` | `false` | Whether to enable let's encrypt to auto generate SSL certificates. |
| gitlab_version | `string` | `""` | GitLab version to install. If the provided string matches several versions the latest one will be installed. If the string does not match any version - the latest GitLab version will be installed. |

## Outputs

The module outputs are defined in the `output.tf` file. They are described in the table below.

| Output | Type | Description |
| -------- | ---- | ----------- |
| gitlab_url | `string` | The URL of the GitLab instance. |
| instance_public_ip | `string` | The public IP of the EC2 instance. |
| instance_public_dns | `string` | The public DNS of the EC2 instance. | 
| instance_private_ip | `string` | The private IP of the EC2 instance. |
| instance_id | `string` | The Id of the GitLab instance. |
| instance_interface_id | `string` | The Id of the GitLab instance network interface. |

## Caveats

Some of the known caveats when using the module

* After the Terraform run finishes it will take some time (around 10 mins.) for the GitLab application to actually be available on the output URL. Terraform is not aware of the user data script that are run on the EC2 instance to perform the GitLab installation.

## Examples

Some examples of using the module are placed in the `examples/` directory.

* In `examples/basic` there is simple definition of the module, using a minimum of input variables.
* In `examples/full` there is a more comprehensive use of the module. The root module in that example defines a set of additional AWS resource that would be needed to provision the GitLab instance like, VPC, subnet, DNS record and also sets up GitLab to use HTTPS with a let's encrypt issued certificate. Please check the [Caveats](#caveats) section for use.
