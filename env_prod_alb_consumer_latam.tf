resource "aws_lb" "prod_alb_consumer_latam" {
  name               = "prod-alb-consumer-latam"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-consumer-latam" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_consumer_latam" {
name = "prod-tg-alb-consumer-latam"
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

resource "aws_lb_target_group_attachment" "prod_alb_consumer_latam_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_latam_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_latam_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_latam_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_consumer_latam_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_consumer_latam.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_consumer_latam_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_consumer_latam.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # firestone.cl
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/fb04e99f-405d-4acb-979e-ada9cfdc4b99"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer_latam.arn}"
  }
}

# Certificates for APAC ALB

# bridgestone.cl
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_cl" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/26321fc2-267b-4510-8ca1-debde7acc184"
}

#bridgestone.co.cr

resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_co_cr" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/a508313e-3959-4b57-b2d8-2ec44944d401"
}

#bridgestone.com.ar

resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_com_ar" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/92bb9bb1-c569-4e23-851e-73f9a4bfdbb5"
}

#bridgestone.com.br

resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_com_br" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/aa49239e-a402-4d10-b4e9-dc8fc9ff99f0"
}

#bridgestone.com.co

resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_com_co" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/1b853298-7a7e-4196-9ae7-6c92b67e61b3"
}

#bridgestone.com.mx
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_bridgestone_com_mx" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/fc30990c-89e7-4990-9b59-b75b7aabd391"
}

#fanbridgestone.com
 resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_fanbridgestone_com" {
   listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
   certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/f74b40b5-1402-45b3-b542-835e85742eae"
 }
#firestone.co.cr

resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_firestone_co_cr" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/2191d411-c1f3-40e6-b821-2206863e587e"
}
#firestone.com.ar
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_firestone_com_ar" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/3cdbc099-33af-485b-9c64-0eaa5ba0e0eb"
}

# firestone.com.br
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_firestone_com_br" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/0ff9a21e-7f88-4e82-b8b7-2a6193950aa6"
}

# firestone.com.co
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_firestone_com_co" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/968d7909-93f7-446d-8a29-48657a0230a6"
}

# firestone.com.mx
resource "aws_lb_listener_certificate" "prod_alb_consumer_latam_listener_certificate_firestone_com_mx" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/7a060d16-c494-4187-b591-d5d327b2f676"
}
