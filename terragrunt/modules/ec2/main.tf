# Provider
provider "aws" {
  region = var.region
}

# EC2 Instance
resource "aws_instance" "linux_server" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  key_name                    = var.ssh_key_name
  security_group_ids          = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "TerraformLinuxInstance"
  }
}
