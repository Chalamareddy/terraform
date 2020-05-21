# # Create ELB for PROD with SSL
# resource "aws_elb" "elb_prod_ssl" {
#   name               = "${element(var.ec2_elb_prod_ssl, count.index)}"
#   count              = "${length(var.ec2_elb_prod_ssl)}"
#   subnets            = ["${element(aws_subnet.elb_prod.*.id, 0)}", "${element(aws_subnet.elb_prod.*.id, 1)}", "${element(aws_subnet.elb_prod.*.id, 2)}"]
#   security_groups    = ["${aws_security_group.sg_elb_prod.*.id}"]

#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   listener {
#     instance_port      = 80
#     instance_protocol  = "http"
#     lb_port            = 443
#     lb_protocol        = "https"
#     ssl_certificate_id = "${element(var.prod_ssl_certificate, count.index)}"
#   }

#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 2
#     timeout             = 5
#     target              = "HTTP:80/index.html"
#     interval            = 30
#   }

#   instances                   = ["${aws_instance.prod-varnish1.id}", "${aws_instance.prod-varnish2.id}", "${aws_instance.prod-varnish3.id}", "${aws_instance.prod-varnish4.id}"]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 60
#   connection_draining         = true
#   connection_draining_timeout = 400
#   internal = "false"

#   tags { "Name" = "${element(var.ec2_elb_prod_ssl, count.index)}" "terraform" = "yes"}
# }
