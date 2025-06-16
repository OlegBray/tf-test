################

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}
variable "owner" {
  description = "Owner of the instance"
}
variable "environment" {
  description = "Environment (e.g., dev/stage/prod)"
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

################

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
