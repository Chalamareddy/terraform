####ALB for identity####
resource "aws_lb" "alb_identity" {
  name               = "alb-prod-identity"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_elb_prod.*.id}"]
  tags { "Name" = "alb-prod-identity" "terraform" = "yes"}
}

resource "aws_lb_target_group" "alb_identity_target_group" {
name = "prod-tg-identity-http"
port = 80
protocol = "HTTP"
vpc_id = "${aws_vpc.cwhvpcprod.id}"
health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = "80"
  }
}

resource "aws_lb_listener" "identity_listener_http" {
   load_balancer_arn = "${aws_lb.alb_identity.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_identity_target_group.arn}"
  }
}

resource "aws_lb_listener" "identity_listener_https" {
load_balancer_arn = "${aws_lb.alb_identity.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/f4b5338e-398c-4cda-8862-26d141b2ad73"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_identity_target_group.arn}"
  }
}