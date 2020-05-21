resource "aws_lb" "prod_alb_author" {
  name               = "prod-alb-author"
  load_balancer_type = "application"
  subnets            = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}"]
  security_groups    = ["${aws_security_group.sg_alb_prod.*.id}"]
  tags { "Name" = "prod-alb-author" "terraform" = "yes"}
}

resource "aws_lb_target_group" "prod_alb_author_tg" {
name = "prod-alb-author-tg"
port = 80
protocol = "HTTP"
vpc_id = "${aws_vpc.cwhvpcprod.id}"
health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/libs/granite/core/content/login.html"
    port                = "80"
  }
}

resource "aws_lb_target_group_attachment" "prod_alb_author_aws_lb_target_group_attachment_author1" {
  target_group_arn = "${aws_lb_target_group.prod_alb_author_tg.arn}"
  target_id        = "${aws_instance.prod-apache-author-1.id}"
  port             = 80
}
resource "aws_lb_target_group_attachment" "prod_alb_author_aws_lb_target_group_attachment_author2" {
  target_group_arn = "${aws_lb_target_group.prod_alb_author_tg.arn}"
  target_id        = "${aws_instance.prod-apache-author-2.id}"
  port             = 80
}


resource "aws_lb_listener" "prod_alb_author_listener_http" {
load_balancer_arn = "${aws_lb.prod_alb_author.arn}"
port = "80"
   protocol = "HTTP"

   default_action {
    type  = "redirect"
    redirect{
	port = "443"
    	protocol = "HTTPS"
    	status_code = "HTTP_301"
    }
}
}
resource "aws_lb_listener" "prod_alb_author_listener_https" {
load_balancer_arn = "${aws_lb.prod_alb_author.arn}"
port = "443"
   protocol = "HTTPS"
   ssl_policy = "ELBSecurityPolicy-2016-08"
   # content.bridgestoneamericas.com
   certificate_arn= "arn:aws:acm:us-west-2:116307434611:certificate/a76d03fc-f180-40e5-9f84-a516ef6a47ff"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prod_alb_author_tg.arn}"
  }
}
