# Create security group for ALB in PROD
resource "aws_security_group" "sg_alb_prod" {
    name = "prod-sg-alb-global"
    description = "Security Group attached to ALB in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-alb-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for ELB in PROD
resource "aws_security_group" "sg_elb_prod" {
    name = "prod-sg-elb-global"
    description = "Security Group attached to ELB in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-elb-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}
# Create global security group for PROD
resource "aws_security_group" "sg_global_prod" {
    name = "prod-sg-global"
    description = "Security Group attached to all servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.0.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.1.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.2.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.3.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.10.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.11.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.12.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.13.0/24"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.20.30.18/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.20.30.193/32"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.20.30.193/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 5666 to_port = 5666 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.10.137/32"]}
    ingress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.10.132/32"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.0.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.1.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.2.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.3.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.10.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.11.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.12.0/24"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.10.13.0/24"]}
    egress { from_port = 123 to_port = 123 protocol = "udp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.10.137/32"]}
    egress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.20.30.17/32"]}
    egress { from_port = 17123 to_port = 17123 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
}

# Create security group for Varnish in PROD
resource "aws_security_group" "sg_varnish_prod" {
    name = "prod-sg-varnish-global"
    description = "Security Group attached to Varnish servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-varnish-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24", "10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.5/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.101/32"]}
    egress { from_port = 514 to_port = 514 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
}

# Create security group for Varnish throttle in PROD
resource "aws_security_group" "sg_varnish_th_prod" {
    name = "prod-sg-varnish-throttle"
    description = "Security Group attached to Varnish throttle servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-varnish-throttle" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.5/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.101/32"]}
    egress { from_port = 514 to_port = 514 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
}

# Create security group for Apache author in PROD
resource "aws_security_group" "sg_apache_author_prod" {
    name = "prod-sg-apache-author"
    description = "Security Group attached to Apache-Author servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-apache-author" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["199.48.30.0/24"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["199.48.30.0/24"]}
    ingress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.10.138/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["208.76.173.140/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 4502 to_port = 4502 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    egress { from_port = 4502 to_port = 4502 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    egress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["199.48.30.0/24"]}
    egress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.10.138/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

# Create security group for Apache-1 in PROD
resource "aws_security_group" "sg_apache1_prod" {
    name = "prod-sg-apache-1"
    description = "Security Group attached to Apache-1 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-apache-1" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.3.102/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" prefix_list_ids = ["${aws_vpc_endpoint.endpoint-s3.prefix_list_id}"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" ipv6_cidr_blocks = ["::/0"]}
}

# Create security group for Apache-2 in PROD
resource "aws_security_group" "sg_apache2_prod" {
    name = "prod-sg-apache-2"
    description = "Security Group attached to Apache-2 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-apache-2" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.38/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.38/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" prefix_list_ids = ["${aws_vpc_endpoint.endpoint-s3.prefix_list_id}"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" ipv6_cidr_blocks = ["::/0"]}
}

# Create security group for Apache-3 in PROD
resource "aws_security_group" "sg_apache3_prod" {
    name = "prod-sg-apache-3"
    description = "Security Group attached to Apache-3 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-apache-3" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.70/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.2.70/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" prefix_list_ids = ["${aws_vpc_endpoint.endpoint-s3.prefix_list_id}"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" ipv6_cidr_blocks = ["::/0"]}
}

# Create security group for Apache-4 in PROD
resource "aws_security_group" "sg_apache4_prod" {
    name = "prod-sg-apache-4"
    description = "Security Group attached to Apache-4 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-apache-4" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.102/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.3.102/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" prefix_list_ids = ["${aws_vpc_endpoint.endpoint-s3.prefix_list_id}"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" ipv6_cidr_blocks = ["::/0"]}
}

# Create security group for Publish-1 in PROD
resource "aws_security_group" "sg_publish1_prod" {
    name = "prod-sg-publish-1"
    description = "Security Group attached to Publish-1 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-publish-1" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.5/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.3.101/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.30.14/32", "10.20.30.18/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    egress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["103.16.59.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

# Create security group for Publish-2 in PROD
resource "aws_security_group" "sg_publish2_prod" {
    name = "prod-sg-publish-2"
    description = "Security Group attached to Publish-2 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-publish-2" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.30.14/32", "10.20.30.18/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.40.132/32"]}
    egress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["103.16.59.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

# Create security group for Publish-3 in PROD
resource "aws_security_group" "sg_publish3_prod" {
    name = "prod-sg-publish-3"
    description = "Security Group attached to Publish-3 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-publish-3" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.30.14/32", "10.20.30.18/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.40.132/32"]}
    egress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["103.16.59.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

# Create security group for Publish-4 in PROD
resource "aws_security_group" "sg_publish4_prod" {
    name = "prod-sg-publish-4"
    description = "Security Group attached to Publish-4 servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-publish-4" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.3.101/32", "10.10.0.5/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.30.14/32", "10.20.30.18/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.20.40.132/32"]}
    egress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["103.16.59.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

# Create security group for Author in PROD
resource "aws_security_group" "sg_author_prod" {
    name = "prod-sg-author-global"
    description = "Security Group attached to Author servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-author-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 4502 to_port = 4502 protocol = "tcp" cidr_blocks = ["10.10.0.8/32"]}
    ingress { from_port = 4502 to_port = 4502 protocol = "tcp" cidr_blocks = ["10.20.30.18/32"]}
    ingress { from_port = 4502 to_port = 4502 protocol = "tcp" cidr_blocks = ["10.10.1.61/32"]}
    ingress { from_port = 8023 to_port = 8023 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 8023 to_port = 8023 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.1.38/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.2.70/32"]}
    egress { from_port = 4503 to_port = 4503 protocol = "tcp" cidr_blocks = ["10.10.3.102/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["103.16.59.20/32"]}
    egress { from_port = 8023 to_port = 8023 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    egress { from_port = 8023 to_port = 8023 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
}

## Create security group for Usermanager-1 in PROD
#resource "aws_security_group" "sg_usermanager1_prod" {
#    name = "prod-sg-usermanager1-global"
#    description = "Security Group attached to USERMANAGER-1 servers in PROD environment"
#    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
#    tags {"Name" = "prod-sg-usermanager-1" "terraform" = "yes" "env" = "prod"}
#    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
#    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
#    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
#    ingress { from_port = 137 to_port = 137 protocol = "tcp" cidr_blocks = ["10.10.11.41/32"]}
#    ingress { from_port = 138 to_port = 138 protocol = "tcp" cidr_blocks = ["10.10.11.41/32"]}
#    ingress { from_port = 139 to_port = 139 protocol = "tcp" cidr_blocks = ["10.10.11.41/32"]}
#    ingress { from_port = 445 to_port = 445 protocol = "tcp" cidr_blocks = ["10.10.11.41/32"]}
#    ingress { from_port = 3389 to_port = 3389 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
#    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"]}
#}

# Create security group for Usermanager-2 in PROD
#resource "aws_security_group" "sg_usermanager2_prod" {
#    name = "prod-sg-usermanager2-global"
#    description = "Security Group attached to USERMANAGER-2 servers in PROD environment"
#    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
#    tags {"Name" = "prod-sg-usermanager-2" "terraform" = "yes" "env" = "prod"}
#    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
#    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
#    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
#    ingress { from_port = 137 to_port = 137 protocol = "tcp" cidr_blocks = ["10.10.10.12/32"]}
#    ingress { from_port = 138 to_port = 138 protocol = "tcp" cidr_blocks = ["10.10.10.12/32"]}
#    ingress { from_port = 139 to_port = 139 protocol = "tcp" cidr_blocks = ["10.10.10.12/32"]}
#    ingress { from_port = 445 to_port = 445 protocol = "tcp" cidr_blocks = ["10.10.10.12/32"]}
#    ingress { from_port = 3389 to_port = 3389 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
#    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"]}
#}

# Create security group for Tomcat in PROD
resource "aws_security_group" "sg_tomcat_prod" {
    name = "prod-sg-tomcat-global"
    description = "Security Group attached to Tomcat servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-tomcat-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    ingress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    ingress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    ingress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    ingress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    ingress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.4/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.16/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.36/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.68/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.3.100/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.39/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.0.5/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.3.101/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.20.30.18/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.14.0/24"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.15.0/24"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.16.0/24"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.17.0/24"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.20.30.17/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.3.101/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.69/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.37/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.5/32"]}
    ingress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 2181 to_port = 2181 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 2888 to_port = 2888 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 3888 to_port = 3888 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.21/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.50/32"]}
    egress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.51/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    egress { from_port = 8983 to_port = 8983 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    egress { from_port = 11211 to_port = 11211 protocol = "tcp" cidr_blocks = ["10.10.0.20/32", "10.10.1.50/32"]}
    egress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["66.231.91.46/32"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" prefix_list_ids = ["${aws_vpc_endpoint.endpoint-s3.prefix_list_id}"]}
}

# Create security group for Mysql in PROD
resource "aws_security_group" "sg_mysql_prod" {
    name = "prod-sg-mysql-global"
    description = "Security Group attached to Mysql servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-mysql-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.0.20/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.0.21/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.1.50/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.1.51/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.11/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.9/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.40/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.2.71/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.20.30.18/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.14.0/24"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.15.0/24"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.16.0/24"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.17.0/24"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.7/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.8/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.0.6/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.1.38/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.2.70/32"]}
    ingress { from_port = 3306 to_port = 3306 protocol = "tcp" cidr_blocks = ["10.10.3.102/32"]}
    ingress { from_port = 8080 to_port = 8080 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 11211 to_port = 11211 protocol = "tcp" cidr_blocks = ["10.10.0.11/32", "10.10.1.40/32", "10.10.2.71/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.0.20/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.0.21/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.1.50/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.1.51/32"]}
}

# Create security group for MSSQL in PROD
resource "aws_security_group" "sg_mssql_prod" {
    name = "prod-sg-mssql-global"
    description = "Security Group attached to MSSQL servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-mssql-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.10.10.12/32"]}
    ingress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.10.0.13/32"]}
    ingress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.10.11.41/32"]}
    ingress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.10.1.42/32"]}
    ingress { from_port = 3389 to_port = 3389 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for LDAP in PROD
resource "aws_security_group" "sg_ldap_prod" {
    name = "prod-sg-ldap-global"
    description = "Security Group attached to LDAP servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-ldap-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 389 to_port = 389 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 10389 to_port = 10389 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 10636 to_port = 10636 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for ADS in PROD
resource "aws_security_group" "sg_ads_prod" {
    name = "prod-sg-ads-global"
    description = "Security Group attached to servers for Active Directory in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-ads-global" "terraform" = "yes" "env" = "prod"}

    #####
    # When bringing up the DR environment - the ingress and egress CIDR blocks need to
    # be changed to the AWS Simple AD DNS address values
    # The following IP addresses need to be changed
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.10.239/32", "10.10.11.232/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.10.239/32", "10.10.11.232/32"]}
    # End of IP addresses change requirement
    #####
}

# Create security group for Internet access in PROD
resource "aws_security_group" "sg_www_prod" {
    name = "prod-sg-www-global"
    description = "Security Group which will be attached to initiate traffic bound for the Internet"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-www-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    ingress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    egress { from_port = 21 to_port = 21 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 25 to_port = 25 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for VPN-NAT in PROD
resource "aws_security_group" "sg_vpnnat_prod" {
    name = "prod-sg-vpnnat-global"
    description = "Security Group attached to VPN-NAT servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-vpnnat-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 1194 to_port = 1194 protocol = "udp" cidr_blocks = ["0.0.0.0/0"]}
    ingress { from_port = 1195 to_port = 1195 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    ingress { from_port = 17123 to_port = 17123 protocol = "tcp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    egress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for VPN-IPSEC in PROD
resource "aws_security_group" "sg_vpnipsec_prod" {
    name = "prod-sg-vpn-ipsec-global"
    description = "Security Group attached to VPN-IPSEC servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-vpn-ipsec-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 500 to_port = 500 protocol = "udp" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 4500 to_port = 4500 protocol = "udp" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "50" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "51" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["199.48.30.0/24"]}
    ingress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.0.0/16"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.0.0/16"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["125.16.91.5/32"]}
    ingress { from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = ["10.150.120.65/32"]}
    ingress { from_port = 51 to_port = 51 protocol = "tcp" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 50 to_port = 50 protocol = "tcp" cidr_blocks = ["199.48.21.9/32"]}
    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["10.10.0.0/16"]}
    egress { from_port = 500 to_port = 500 protocol = "udp" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 51 to_port = 51 protocol = "tcp" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 50 to_port = 50 protocol = "tcp" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 4500 to_port = 4500 protocol = "udp" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 0 to_port = 0 protocol = "50" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 0 to_port = 0 protocol = "51" cidr_blocks = ["199.48.21.9/32"]}
    egress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["199.48.30.0/24"]}
    egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
    egress { from_port = 8 to_port = 0 protocol = "icmp" cidr_blocks = ["10.10.0.0/16"]}
}


resource "aws_security_group" "sg_mssqlw_prod" {
    name = "prod-sg-mssqlw-global"
    description = "Security Group attached to IIS servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-mssqlw-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.20.10.132/32", "10.20.30.105/32" , "10.20.31.105/32"]}
}

# Create security group for IIS in PROD
resource "aws_security_group" "sg_iis_prod" {
    name = "prod-sg-iis-global"
    description = "Security Group attached to IIS servers in PROD environment"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-iis-global" "terraform" = "yes" "env" = "prod"}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.20.0/24"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.21.0/24"]}
    ingress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["10.10.22.0/24"]}
    ingress { from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["10.20.30.233/32"]}
    ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["10.10.20.0/24"]}
	ingress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["10.10.22.0/24"]}
	ingress { from_port = 3389 to_port = 3389 protocol = "tcp" cidr_blocks = ["10.10.10.132/32"]}
    egress { from_port = 1433 to_port = 1433 protocol = "tcp" cidr_blocks = ["10.10.0.0/24"]}
    egress { from_port = 81 to_port = 81 protocol = "tcp" cidr_blocks = ["162.208.85.25/32"]}
    egress { from_port = 587 to_port = 587 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}

# Create security group for Internet access in PROD
resource "aws_security_group" "sg_www_prod_outbound" {
    name = "prod-sg-www-global-outbound"
    description = "Security Group which will be attached to allow HTTP(S) traffic outbound for the Internet"
    vpc_id      = "${aws_vpc.cwhvpcprod.id}"
    tags {"Name" = "prod-sg-www-global-outbound" "terraform" = "yes" "env" = "prod"}
	egress { from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
	egress { from_port = 443 to_port = 443 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"]}
}
