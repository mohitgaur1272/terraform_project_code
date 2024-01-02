resource "aws_lb" "my_load_balancer" {
  name               = "my-terra-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_security_group.id]# Replace with your security group ID(s)
  subnets            = ["subnet-0f23c760a9d8c92e4", "subnet-08862ae7dee8aa99b", "subnet-071854c1d6a908948"]  # Replace with your subnet IDs

  enable_deletion_protection         = false
  enable_http2                       = true
  enable_cross_zone_load_balancing   = true
  idle_timeout                       = 60

  tags = {
    Name        = "my-load-balancer"
    Environment = "production"
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id = "vpc-0794fde5cab1c1c34"

  health_check {
    interval          = 30
    path              = "/"
    port              = 80
    protocol          = "HTTP"
    timeout           = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "my_instance1_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.my_instance1[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "my_instance2_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.my_instance2[0].id
  port             = 80
}

resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb_listener.my_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}