resource "aws_lb" "prod_alb_firestone_bp" {
  name               = "prod-alb-firestone-bp"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-firestone-bp" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_firestone_bp" {
name = "prod-tg-albfirestone-bp"
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

resource "aws_lb_target_group_attachment" "prod_alb_firestone_bp_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_firestone_bp_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_firestone_bp_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_firestone_bp_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_firestone_bp_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_firestone_bp.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
 	type  = "redirect"
    	redirect{
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
   # type             = "forward"
   # target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  }
}
}
resource "aws_lb_listener" "prod_alb_firestone_bp_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_firestone_bp.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/4226b93c-d669-46a1-98c3-8642d4bca33e"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_firestone_bp.arn}"
  }
}

# Certificates for BP ALB

# firestonebp.ca
 resource "aws_lb_listener_certificate" "prod_alb_firestone_bp_listener_certificate_firestonebp_ca" {
   listener_arn    = "${aws_lb_listener.prod_alb_firestone_bp_listener_https.arn}"
   certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/21309679-2315-4e71-9f84-0e3b0b84e774"
 }
