variable "web_image" {
  description = "ami for web server"
}

variable "web_sec_group" {
  description = "security group for web instances"
}

variable "pub1_sub_id" {
  description = "public-1 subnet id"
}

variable "pub2_sub_id" {
  description = "public-2 subnet id"
}

variable "ssh_key_var" {
  description = "keys to the kingdom"
}
