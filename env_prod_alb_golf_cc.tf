resource "aws_lb" "prod_alb_golf_cc" {
  name               = "prod-alb-golf-cc"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-golf-cc" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_golf_cc" {
name = "prod-tg-alb-golf-cc"
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

resource "aws_lb_target_group_attachment" "prod_alb_golf_cc_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_golf_cc_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_golf_cc_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_golf_cc_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_golf_cc_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_golf_cc.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_golf_cc_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_golf_cc.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # bridgestonegolf.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/b6d309ae-28ab-4f25-929e-568b6f002620"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_golf_cc.arn}"
  }
}

# Certificates for APAC ALB

# bebridgestone.com
resource "aws_lb_listener_certificate" "prod_alb_golf_cc_listener_certificate_bebridgestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_golf_cc_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/5e9a6741-3e8a-4b01-9733-42263fbb9f37"
}

#bridgestoneamericas.com

resource "aws_lb_listener_certificate" "prod_alb_golf_cc_listener_certificate_bridgestoneamericas_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_golf_cc_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/a76d03fc-f180-40e5-9f84-a516ef6a47ff"
}

#tiresafety.com
resource "aws_lb_listener_certificate" "prod_alb_golf_cc_listener_certificate_tiresafety_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_golf_cc_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/654cc096-90de-4c9c-b34d-fa1a3f9b4de7"
}

#bridgestonesolutionsportal.com
resource "aws_lb_listener_certificate" "prod_alb_golf_cc_listener_certificate_bridgestonesolutionsportal_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_golf_cc_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/38560f58-abd0-4dd7-99a6-31ee00a18aeb"
}
