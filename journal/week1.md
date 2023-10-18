# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- TODO: document this flag

### terraform.tvfars

This is the default file to load in terraform variables in bulk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence.


## Dealing with conifugration drift

### What happens if we lose our state file?

If you lose the statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't work for all cloud resources. Will need to check the terraform providers documentation for which resources support import. 

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket_example`

[Aws S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configuration

If someone deletes or modifies cloud resource manually throu clickops.

If we run Terraform plan attempting to put our infrastrucutre back in to the expected state fixing configuration drift.

