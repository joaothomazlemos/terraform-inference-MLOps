# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform/OpenTofu that provides extra tools for working with multiple modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
 # this allows the modules that inherit it to have access to the account and region variables from parent folders.
locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))


  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
}
#especify the provider version ( hashicorp provider)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version ~> "5.0"
    }
  }
}
# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  


  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "terragrunt-mlops1-tf-state-${local.account_name}-${local.account_id}"
    key            = "${path_relative_to_include()}/tf.tfstate"
    region         = local.aws_region # us-east-1 ( could be fix)
    dynamodb_table = "tf-mlops1-lock"
  }
  generate = {
    path      = "backend.tf" 
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
# These parameters are automatically get into any child terragrunt.hcl 
# configurations through the use of the include block. Merge is to get account_vars and region_vars to the same key-pair map.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.env_vars.locals,

)