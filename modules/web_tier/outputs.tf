output "web_sec_group_id" {
  description = "web security group id"
  value = aws_security_group.web.id
}

output "public1_subnet_cidrblock" {
  description = "cidr block ip for public1 subnet"
  value = aws_subnet.public1.cidr_block
}

output "public1_subnet_id" {
  description = "public1 subnet id"
  value = aws_subnet.public1.id
}

output "public2_subnet_cidrblock" {
  description = "cidr block ip for public2 subnet"
  value = aws_subnet.public2.cidr_block
}

output "public2_subnet_id" {
  description = "public2 subnet id"
  value = aws_subnet.public2.id
}
output "web_instance_id" {
  description = "web server id"
  value = aws_instance.Web.id
}
