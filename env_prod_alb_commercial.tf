resource "aws_lb" "prod_alb_commercial" {
  name               = "prod-alb-commercial"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}", "${element(aws_subnet.public_prod.*.id, 2)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-commercial" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_tg_alb_commercial" {
name = "prod-tg-alb-commercial"
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

resource "aws_lb_target_group_attachment" "prod_alb_commercial_aws_lb_target_group_attachment_varnish1" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  target_id        = "${aws_instance.prod-varnish1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_aws_lb_target_group_attachment_varnish2" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  target_id        = "${aws_instance.prod-varnish2.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_aws_lb_target_group_attachment_varnish3" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  target_id        = "${aws_instance.prod-varnish3.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_commercial_aws_lb_target_group_attachment_varnish4" {
  target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  target_id        = "${aws_instance.prod-varnish4.id}"
  port             = 80
}

resource "aws_lb_listener" "prod_alb_commercial_listener_http" {
   load_balancer_arn = "${aws_lb.prod_alb_commercial.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  }
}

resource "aws_lb_listener" "prod_alb_commercial_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_commercial.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   #firestone.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/e3a081ed-6d9d-496c-ae19-ad63d6333eea"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_tg_alb_commercial.arn}"
  }
}

# Certificates for APAC ALB

# bandag.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_bandag_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/c82d3f9a-079e-4bfd-b12b-c870b6fdc79d"
}

#daytontrucktires.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_daytontrucktires_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/66a92864-ac39-45f4-b974-6cecc1fddac4"
}

#gcrtires.com

 resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_gcrtires_com" {
   listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
   certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/63e87489-6eae-48af-af33-c538646cf45c"
 }

#thetread.com

resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_thetread_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/f4b5338e-398c-4cda-8862-26d141b2ad73"
}

#www.commercial.bridgestone.com

resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_www_commercial_bridgestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/0ec50cb9-022a-44f1-9c45-ece20b5bb886"
 }

#commercial.bridgestone.com	  
resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_commercial_bridgestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/17d77e4e-9e8e-40eb-926d-d6ea958578c6"
 }             

#bridgestone.com
resource "aws_lb_listener_certificate" "prod_alb_commercial_listener_certificate_bridgestone_com" {
  listener_arn    = "${aws_lb_listener.prod_alb_commercial_listener_https.arn}"
  certificate_arn = "arn:aws:acm:us-west-2:116307434611:certificate/bef6638e-24e4-43f7-8e1a-e39925f6830a"
 } 
