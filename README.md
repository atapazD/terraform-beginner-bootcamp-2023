# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging. 
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and changethe scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distro and change accordingly to your distro needs.

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terrafrom CLI gpg deprecation issues we noticed that bash scripts steps were a considerale amount more code. So we decided to created a bash script to install the Terraform CLI. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File tidy. ([.gitpod.yml](.gitpod.yml))
- This allows easier debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI


### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommneded this fomrat for bash: `#!/usr/bin/env bash`

- for portabilit for different OS distro
- will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(unix)

#### Execution Considerations
When executing the bash script we can use the `./` shorthand notation to execute the bash script. 

eg. `./bin/install_terrafrom_cli`

If we are are using a script in .gitpod.yml we need to point the script to a program to interpret it. 

eg. `source ./bin/install_terrafrom_cli`


#### Linux Permissions Considerations
In order to make our bashs scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:
```sh
chmod 744 ./bin/install_terrafrom_cli
```
https://en.wikipedia.org/wiki/chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an exiting workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

#### env command   

We can list out all NEvironment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bashscript we can set env var without writing export eg.

```sh
#!/usr/bin/env bash
HELLO='world'

echo $HELLO

```
## Printing Vars
We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you set in another window. 

If you want Env Vars to persis across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod
We can persist env vars into gitpod by storing them in Gitpod Screts Storage.

```
gp env HELLO='world'
```

All future worksaces launched will set the env vars for all bash terminals opened in those workspaces

you can also set env vars in the `.getpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installd for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)] (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-isntall.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly y running the following command:
```sh
aws sts get-caller-identity
```

If it is usccessful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDAasdfhjklqw234561k",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```
We'll need to generate AWS CLI credentials from IAM user in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform.

[Random Terrafrom Provider](https://registry.terraform.io/roviders/hashicorp/random)
- **Module** are a way to make large amounts of terraform code modular, portable and sharable 

## Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init
`terraform init`

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan
`terraform plan`

This will generate a changeset about the state of the infrastructure and what will be changed

We can output the change set or "plan" to be passed to an apply, but often you can just ignore outputting

#### Terraform Apply
`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply will prompt yes or no.

If you want to auto approve an apply we can use the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will destroy resources. 

You can also auto approve flag to skip the approve prompt.
eg. `terraform destroy --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` containes the locked versioning for the providers or modules that should be used with the project

The Terraform Lock File **should be committed** to your version control system eg. Github

### Terraform State Files
`.terraform.tfstate` contains info about the current state of your infrastrucutre

This file **should not be commited** to your VCS. 

This file can contain sensitive data and if lost you lose knowing the state of your current infrastructure.

`.terrafrom.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.


## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash in a wisiwig view to generate a toke. However it does not work expected in Gitpod VSCode in the browser. While it is possible to create a token file manually to login to terraform cloud, I was able to manually right click and paste the token generated by terraform cloud to login to terraform cloud in gitpod. 

---
### Manual token creation
```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code in that file:
```json
{
    "credentials": {
        "app.terraform.io": {
            "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
        }
    }
}
```

Automated the process using a workaround using the following bash script [bin/generate_tfrc/credentials](bin/generate_tfrc_credentials).