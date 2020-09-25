# Complex example of the module usage

The example in this directory shows a more complete and complex use of the module.

The root terraform module here will create the underlying network resources, an Elastic IP allocation and a DNS record. It will then invoke the GitLab module providing values for its input variables.

The GitLab installation itself will be configured to use Let's Encrypt to issue a certificate for the defined GitLab URL.

## Usage

* Set up the AWS provider including a region. For example

```bash
export AWS_ACCESS_KEY_ID=<your_aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<your_aws_secret_access_key>
export AWS_REGION=<aws_region>
```

* copy the `example.tfvars` to `example.auto.tfvars` and edit it providing relevant values for the input variables in it.
* initialize Terraform

```bash
terraform init
```

* Have Terraform create the rest of the infrastructure

```bash
terraform apply
```

* Destroy the created resources

```bash
terraform destroy
```
