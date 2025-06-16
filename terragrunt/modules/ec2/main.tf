# Provider
provider "aws" {
  region = var.aws_region
}


resource "random_integer" "id" {
  min = 0
  max = 1
}

locals {
 first_subnet_private = var.private_subnet_ids[random_integer.id.result]
 first_subnet_public = var.public_subnet_ids[random_integer.id.result]
 subnet_id = var.is_public ? local.first_subnet_public : local.first_subnet_private

}

# EC2 Instance
resource "aws_instance" "linux_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_id
  key_name                    = var.ssh_key_name
  vpc_security_group_ids          = [var.sg_ids]
  associate_public_ip_address = var.is_public

  tags = {
    Name = var.instance_name
    Environment = var.environment
  }
}

resource "aws_route53_record" "linux_host_public" {
  count   = var.is_public ? 1 : 0
  zone_id = var.route53_hostedzone_id
  name    = var.instance_name
  type    = "A"
  ttl     = 300

  records = [
    aws_instance.linux_server.public_ip
  ]
}

resource "aws_route53_record" "linux_host_private" {
  count   = var.is_public ? 0 : 1
  zone_id = var.route53_hostedzone_id
  name    = var.instance_name
  type    = "A"
  ttl     = 300

  records = [
    aws_instance.linux_server.private_ip
  ]
}

