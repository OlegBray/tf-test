# Provider
provider "aws" {
  region = var.aws_region
}

resource "random_shuffle" "public_subnets" {
  input        = var.public_subnet_ids
  result_count = 1
}

# EC2 Instance
resource "aws_instance" "linux_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id     = random_shuffle.public_subnets.result[0]
  key_name                    = var.ssh_key_name
  vpc_security_group_ids          = [var.sg_ids]
  associate_public_ip_address = true

  tags = {
    Name = var.Name
    Owner = var.owner
  }
}
