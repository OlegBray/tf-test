
variable "aws_region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID for Linux"
  # You can override this variable during terraform apply
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

variable "instance_name" {
}

variable "environment" {
}

variable "is_public" {
	type = bool
	default = false
}

variable "private_subnet_ids" {
	type = list
}

variable "public_subnet_ids" {
	type = list
}

variable "route53_hostedzone_id" {
  type = string
}
