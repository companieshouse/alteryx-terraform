# aws-alteryx-terraform
## What is this repo?
This repo contains the Terraform code required to build out Alteryx environments in Shared Services.
This code includes an Alteryx Server node and a Worker node and all relevant resources to support these services.

## The Groups of Terraform
### groups/alteryx-sandbox
Alteryx Sandbox infrastructure code that builds an Alteryx Server node and relevant resources such as Route53 entry and IAM profile.

### groups/alteryx-live
Alteryx Live infrastructure code, matches sandbox but has an additional worker node and resources for that node.
