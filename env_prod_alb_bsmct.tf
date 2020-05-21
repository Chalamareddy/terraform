resource "aws_lb" "prod_alb_bsmct" {
  name               = "prod-alb-bsmct"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-bsmct" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_bsmct" {
name = "prod-tg-alb-bsmct"
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

resource "aws_lb_target_group_attachment" "prod_alb_bsmct_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsmct_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsmct_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsmct_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_bsmct_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_bsmct.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_bsmct_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_bsmct.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # bridgestonemotorcycletires.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/f2847430-02c7-4c94-9b91-cdf1f0d32d84"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsmct.arn}"
  }
}