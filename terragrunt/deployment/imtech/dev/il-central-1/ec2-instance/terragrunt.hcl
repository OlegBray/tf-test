include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
    source      = "../../../../../modules/ec2"
}

