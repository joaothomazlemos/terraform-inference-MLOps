include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../"
}

locals {
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  aws_region     = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id
}

inputs = {
  account_id = local.aws_account_id
  region     = local.aws_region
}