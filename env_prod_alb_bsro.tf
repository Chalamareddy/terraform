resource "aws_lb" "prod_alb_bsro" {
  name               = "prod-alb-bsro"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-bsro" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_bsro" {
name = "prod-tg-alb-bsro"
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

resource "aws_lb_target_group_attachment" "prod_alb_bsro_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsro_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsro_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_bsro_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_bsro_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_bsro.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_bsro_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_bsro.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # firestonecompleteautocare.com
   #certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/ccb79a89-499f-437f-8319-2041f7a485fc"
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/2adfb839-3e7d-459f-93a2-8fb4e0b482dc"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_bsro.arn}"
  }
}

# Certificates for BSRO ALB

# bsro.com
resource "aws_lb_listener_certificate" "prod_alb_bsro_listener_certificate_bsro_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_bsro_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/82a39479-40b9-48fc-b005-487ebd46918a"
}

# hibdontire.com
resource "aws_lb_listener_certificate" "prod_alb_bsro_listener_certificate_hibdontire_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_bsro_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/d2555768-a317-40d0-8098-cc161756f65e"
}

#tiresplus.com
resource "aws_lb_listener_certificate" "prod_alb_bsro_listener_certificate_tiresplus_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_bsro_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/03d87ab5-a2dd-42ae-8ba7-f96a591dfbec"
}

#wheelworks.net
resource "aws_lb_listener_certificate" "prod_alb_bsro_listener_certificate_wheelworks_net" {
  listener_arn    = "${aws_lb_listener.prod_alb_bsro_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/a65e8f19-8475-42af-b7ff-f2acb39a605d"
}
