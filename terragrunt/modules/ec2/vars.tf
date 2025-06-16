
variable "aws_region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID for Linux"
  # You can override this variable during terraform apply
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to choose from"
  type        = list(string)
}


variable "ssh_key_name" {
  description = "Name of the existing Key Pair"
}

variable "sg_ids" {
  description = "Security Group ID to associate with the instance"
}

variable "instance_type" {
	default = "t3.large"
}
variable "owner" {
  description = "Owner tag for resources"
  type        = string
}
variable "Name" {
  description = "Name tag for resources"
  type        = string
}

