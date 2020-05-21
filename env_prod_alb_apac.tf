resource "aws_lb" "prod_alb_apac" {
  name               = "prod-alb-apac"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-apac" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_apac" {
name = "prod-tg-alb-apac"
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

resource "aws_lb_target_group_attachment" "prod_alb_apac_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_apac_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_apac_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_apac_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_apac_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_apac.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_apac_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_apac.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/1cf39080-b1a0-4911-9841-1978e84a1b31"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_apac.arn}"
  }
}

# Certificates for APAC ALB

# bridgestone.korea.co.kr
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone-korea_co_kr" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/6f80573b-f8ae-423d-892b-eb6e33e9fe2f"
}

#bridgestone.asiapacific.com
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_asiapacific_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/9ce977ad-6c26-4b66-9f26-a740077260dc"
}

#bridgestone.co.id
# resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_co_id" {
#   listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
#   certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/2f57483e-22ef-4d50-9821-a83c59d1f9ba"
# }

#bridgestone.co.in
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_co_in" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/8d25e6eb-5c4c-4994-90e7-5006df174afe"
}

#bridgestone.co.th
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_co_th" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/2a87de61-f536-4f40-9d3d-d804dc4fd567"
}
#bridgestone.com.sg
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_com_sg" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/714b9949-5c47-41b7-aa34-c76b7b60b2f6"
}
#bridgestone.com.tw
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_com_tw" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/1cf39080-b1a0-4911-9841-1978e84a1b31"
}
#bridgestone.com.vn
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_com_vn" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/09c64812-6be0-4ed7-8be9-1d04ec883560"
}
#bridgestone.com.my
 resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_com_my" {
   listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
   certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/9eee79f7-72cb-4dff-a45a-a5ace0fffa52"
 }
#bridgestone.co.id
resource "aws_lb_listener_certificate" "prod_alb_apac_listener_certificate_bridgestone_co_id" {
  listener_arn    = "${aws_lb_listener.prod_alb_apac_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/073047dd-d541-4dc0-b5aa-854e91c0e6ee"
}
