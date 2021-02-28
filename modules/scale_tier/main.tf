resource "aws_launch_template" "web_image" {
  name = "Stefan-tf-AND-Template"
  image_id      = var.web_image
  instance_type = "t2.micro"
  key_name = var.ssh_key_var
  vpc_security_group_ids = [var.web_sec_group]
}

resource "aws_autoscaling_group" "scales" {
  vpc_zone_identifier = [var.pub1_sub_id, var.pub2_sub_id]
  desired_capacity   = 2
  max_size = 5
  min_size = 2

  launch_template {
    id      = aws_launch_template.web_image.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "Reinforcements.Stefan"
    propagate_at_launch = true
  }
}
