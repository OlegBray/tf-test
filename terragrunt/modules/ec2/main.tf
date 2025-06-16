# Provider
provider "aws" {
  region = var.aws_region
}

# EC2 Instance
resource "aws_instance" "linux_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.ssh_key_name
  vpc_security_group_ids          = [var.sg_ids]
  associate_public_ip_address = true

  tags = {
    Name = "TerraformLinuxInstance"
  }
}
