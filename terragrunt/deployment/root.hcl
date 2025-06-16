locals {

  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))

  tier      = local.deployment_path_components[0]  # takes the fist parameter (i.e. 'nutrino')
  tf_module = reverse(local.deployment_path_components)[0] # takes the last parameter (i.e. 'eks')



  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
  for i in range(0, length(local.deployment_path_components) + 1) :
  join("/", concat(
  [local.root_deployments_dir],
  slice(local.deployment_path_components, 0, i)
  ))
  ]



 # Generate a list of possible config files at every possible_config_dir
 # (support both .yml and .yaml)
 possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.yml",
      "${dir}/config.yaml"
    ]
  ])


  # Load every YAML config file that exists into an HCL map
  file_configs = [
    for path in local.possible_config_paths :
    yamldecode(file(path)) if fileexists(path)
  ]

  # Merge the maps together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)
  instance_name = "${local.project}-instance-${local.environment}"
  project     = local.merged_config.project
  account_id  = local.merged_config.account_id
  environment = local.merged_config.environment
  aws_region  = local.merged_config.aws_region
  bucket_region = local.merged_config.bucket_region


}

inputs = local.merged_config


generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
    required_version = ">= 1.1"
    backend "s3" {}
}
EOF
}

remote_state {
  backend = "s3"
  config  = {
    bucket         = "${local.project}-terraform-${local.environment}"
    key            = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    region         = local.bucket_region
  }
}

