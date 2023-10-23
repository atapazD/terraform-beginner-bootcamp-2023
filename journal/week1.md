# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag

```sh
git tag -d <tag_name>
```

Remotely delete tag
```sh
git push --delete origin <tagname>
```

checkout the commit that you want to retag. Grab the SHA from your github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only --auto-approve
```

## Terraform Modules

### Terrafrom Module Structure

It is reccomended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws"{
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
### Modules Sources

Using the source we can import the module from various places such as:
    - locally
    - Gihub
    -Terraform Reigstry
```tf
module "terrahouse_aws"{
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprectated. Often affecting providers used in terraform code.

## Working with files in Terraform

### Fileexissts function

This is a built in terraform function that checks the existance of a file.
```tf
condition     = fileexists(var.index_html_filepath)
```
https://developer.hashicorp.com/terraform/language/functions/fileexists

### File MD5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable
In Terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[special path variable](https://developer.hashicorp.com/terraform/language/expressions/references)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html
  
  etag = filemd5(var.index_html_filepath)
}
```

### Terraform Locals
```tf
locals {
    s3_origin_id = "MyS3Origin"
}

```

Local values can be helpful to avoid repeating the same values or expressions multiple times in a configuration, but if overused they can also make a configuration hard to read by future maintainers by hiding the actual values used.

The ability to easily change the value in a central place is the key advantage of local values.

[Locals Value](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows to source data from cloud resources. Usfeul when we want to reference cloud resources without importing them

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON
We use the jsonencode to create the json policy inline in the hcl.
```js
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources



[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}

```
[Terraform_data Managed Resource Type](https://developer.hashicorp.com/terraform/language/resources/terraform-data
)

## Provisioners

Provisioners allows you to execute commands on compute instances. eg . a AWS CLI command.

Not recommended for use by Hashicorp because config managemtn tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)
### Local-exec

This will execute a command on the machine running the terraform commands eg plan apply
```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}

```
### Remote-exec

this will execuate commands on the machine which you target. You will have to provide credentials such as SSH to get into the machine
```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```
