
variable "aws_region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID for Linux"
  # You can override this variable during terraform apply
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
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
