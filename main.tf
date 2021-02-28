terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "VPC" {
  cidr_block       = "33.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}.VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "${var.name}.IGW"
  }
}


module "web_tier" {
  source = "./modules/web_tier"

  vpc_id = aws_vpc.VPC.id
  tag_name = var.name
  ssh_key_var = var.ssh_key
  web_image = var.ubuntu-nginx-ami
  igw_id = aws_internet_gateway.igw.id
}

module "lb_tier" {
  source = "./modules/lb_tier"

  vpc_id = aws_vpc.VPC.id
  pub1_sub_id = module.web_tier.public1_subnet_id
  pub2_sub_id = module.web_tier.public2_subnet_id
}

module "scale_tier" {
  source = "./modules/scale_tier"

  web_image = var.ubuntu-nginx-ami
  web_sec_group = module.web_tier.web_sec_group_id
  pub1_sub_id = module.web_tier.public1_subnet_id
  pub2_sub_id = module.web_tier.public2_subnet_id
  ssh_key_var = var.ssh_key
}
