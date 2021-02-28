resource "aws_subnet" "public1" {
  vpc_id = var.vpc_id
  cidr_block = "33.0.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}.Pub1.Subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = var.vpc_id
  cidr_block = "33.0.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}.Pub2.Subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
    }

    tags = {
      Name = "${var.tag_name}.Route.Pub"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "web" {
  name        = "${var.tag_name}.Web.SG"
  description = "Allow http and https inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}.Web.SG"
  }
}

resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "${var.tag_name}.NACL.Pub"
  }
}


resource "aws_instance" "Web" {
  ami  = var.web_image
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name = var.ssh_key_var
  associate_public_ip_address = true

  tags = {
    Name = "${var.tag_name}.Web"
  }
}
