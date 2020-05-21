resource "aws_lb" "prod_alb_commercial_latam" {
  name               = "prod-alb-commercial-latam"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-commercial-latam" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_commercial_latam" {
name = "prod-tg-alb-commercial-latam"
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

resource "aws_lb_target_group_attachment" "prod_alb_commercial_latam_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_latam_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_latam_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_latam_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_commercial_latam_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_commercial_latam.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_commercial_latam_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_commercial_latam.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # bandag-lan.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/00126e54-dad9-428c-b601-5361aa47bc3b"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial_latam.arn}"
  }
}

# Certificates for APAC ALB

#bandag-sur.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bandag_sur_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/e907349c-84d0-4d61-be59-e384eca10bce"
}

#bandag.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bandag_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/c82d3f9a-079e-4bfd-b12b-c870b6fdc79d"
}

#bandag.com.br

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bandag_com_br" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/0b28db69-502c-4ea0-881c-f8e1697cccee"
}

#bridgestonecomercial.cl

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_cl" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/5ec9acea-62c9-482c-b0b5-7d4cc8652ccd"
}
# bridgestonecomercial.co.cr

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_co_cr" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/b7a50234-d052-4373-810a-9ea1fca6fe25"
}
#bridgestonecomercial.com.ar

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_com_ar" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/3c3de53a-8118-4f89-b27d-f5245d3676ca"
}
#bridgestonecomercial.com.br

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_com_br" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/300ef272-62c0-4212-9da4-3aa5adf8c353"
}
#bridgestonecomercial.com.co

resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_com_co" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/7c989ecf-d4b1-4b05-aa08-3937a8908771"
}

#bridgestonecomercial.com.mx
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_bridgestonecomercial_com_mx" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/ec1b446c-ffdd-4672-b151-6fc5e96eabb4"
}

#daytontrucktires.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_daytontrucktires_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/66a92864-ac39-45f4-b974-6cecc1fddac4"
}

#firestonecomercial.cl
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_cl" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/b481b08d-7637-41ae-80aa-465f1cb611d1"
}

# firestonecomercial.co.cr
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_co_cr" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/cae7c584-f467-4c8d-b939-7749dd3e5a5f"
}

#firestonecomercial.com.ar
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_com_ar" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/95b7aa22-343b-4349-a1a9-fe70597913a4"
}

#firestonecomercial.com.br
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_com_br" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/72fa8812-2e5c-40ad-ae6f-fc3ef48c02d1"
}

#firestonecomercial.com.co
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_com_co" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/14203408-02fd-452f-a9f2-665877c05e1c"
}

#firestonecomercial.com.mx
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_firestonecomercial_com_mx" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/a54456f0-c122-4753-acf9-dbf23eeeec72"
}

#thetread.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_thetread_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/f4b5338e-398c-4cda-8862-26d141b2ad73"
}

#gcrtires.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_gcrtires_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/63e87489-6eae-48af-af33-c538646cf45c"
}

#commercial.bridgestone.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_commercial_bridgestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/17d77e4e-9e8e-40eb-926d-d6ea958578c6"
}

#commercial.firestone.com
#resource "aws_lb_listener_certificate" "prod_alb_commercial_latam_listener_certificate_commercial_firestone_com" {
#  listener_arn    = "${aws_lb_listener.prod_alb_commercial_latam_listener_https.arn}"
#  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/fd183cc0-928d-4bf1-b9c1-fca465fe103f"
#}
