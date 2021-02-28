resource "aws_lb" "LB" {
  name = "Stefan-AND-LB"
  internal = false
  load_balancer_type = "network"

  subnets = [var.pub1_sub_id, var.pub2_sub_id]


  tags = {
    Environment = "Stefan.production"
  }
}

resource "aws_lb_target_group" "targeter" {
  name = "Stefan-LB-tg"
  port = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
  target_type = "ip"
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.LB.arn
  port = 80
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.targeter.arn
  }
}
