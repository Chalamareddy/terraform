resource "aws_lb" "prod_alb_consumer" {
  name               = "prod-alb-consumer"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-consumer" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_consumer" {
name = "prod-tg-alb-consumer"
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

resource "aws_lb_target_group_attachment" "prod_alb_consumer_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_consumer_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_consumer_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_consumer.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_consumer_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_consumer.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # bridgestonetire.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/9445198c-cf93-4feb-9055-4ef8171b489a"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_consumer.arn}"
  }
}

# Certificates for APAC ALB

# bridgestonetire.ca
resource "aws_lb_listener_certificate" "prod_alb_consumer_listener_certificate_bridgestonetire_ca" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/237d2c37-ab69-4340-b21a-49fd2f37f68b"
}

#firestone.com
resource "aws_lb_listener_certificate" "prod_alb_consumer_listener_certificate_firestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/f71d2811-7a43-4319-8f46-da0bdfe7e728"
}

#firestonetire.ca
resource "aws_lb_listener_certificate" "prod_alb_consumer_listener_certificate_firestonetire_ca" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/a5fb6b1a-74b7-4a7c-9504-0bff2778fda8"
}

#firestonetire.com
resource "aws_lb_listener_certificate" "prod_alb_consumer_listener_certificate_firestonetire_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_consumer_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/660308a7-19c9-42b7-a719-751be30cc700"
}
