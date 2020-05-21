# Setup VPC for PROD
resource "aws_vpc" "cwhvpcprod" {
  cidr_block           = "${var.cidr_prod}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags { "Name" = "${var.name_prod}" "terraform" = "yes"}
}

# Setup Internet gateway for PROD
resource "aws_internet_gateway" "cwhvpcprod" {
  vpc_id = "${aws_vpc.cwhvpcprod.id}"
  tags{ "Name" = "${format("%s-igw", var.name_prod)}" "terraform" = "yes"}
}

# Setup Private subnets for PROD
resource "aws_subnet" "private_prod" {
  vpc_id            = "${aws_vpc.cwhvpcprod.id}"
  cidr_block        = "${var.private_subnets_prod[count.index]}"
  availability_zone = "${element(var.azs_prod, count.index)}"
  count             = "${length(var.private_subnets_prod)}"
  tags{ "Name" = "${element(var.private_subnets_prod_tags, count.index)}" "terraform" = "yes"}
}

# Setup Public subnets for PROD
resource "aws_subnet" "public_prod" {
  vpc_id            = "${aws_vpc.cwhvpcprod.id}"
  cidr_block        = "${var.public_subnets_prod[count.index]}"
  availability_zone = "${element(var.azs_prod, count.index)}"
  count             = "${length(var.public_subnets_prod)}"
  tags{ "Name" = "${element(var.public_subnets_prod_tags, count.index)}" "terraform" = "yes"}
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

# Setup Lambda subnets for PROD
resource "aws_subnet" "lambda_prod" {
  vpc_id            = "${aws_vpc.cwhvpcprod.id}"
  cidr_block        = "${var.lambda_subnets_prod[count.index]}"
  availability_zone = "${element(var.azs_prod, count.index)}"
  count             = "${length(var.lambda_subnets_prod)}"
  tags{ "Name" = "${element(var.lambda_subnets_prod_tags, count.index)}" "terraform" = "yes"}
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

# # Setup ALB subnets for PROD
# resource "aws_subnet" "alb_prod" {
#   vpc_id            = "${aws_vpc.cwhvpcprod.id}"
#   cidr_block        = "${var.public_subnets_prod[count.index]}"
#   availability_zone = "${element(var.azs_prod, count.index)}"
#   count             = "${length(var.public_subnets_prod)}"
#   tags{ "Name" = "${element(var.public_subnets_prod_tags, count.index)}" "terraform" = "yes"}
#   map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
# }

# Setup ELB subnets for PROD
# resource "aws_subnet" "elb_prod" {
#   vpc_id            = "${aws_vpc.cwhvpcprod.id}"
#   cidr_block        = "${var.elb_subnets_prod[count.index]}"
#   availability_zone = "${element(var.azs_prod, count.index)}"
#   count             = "${length(var.elb_subnets_prod)}"
#   tags{ "Name" = "${element(var.elb_subnets_prod_tags, count.index)}" "terraform" = "yes"}
#   map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
# }

resource "aws_db_subnet_group" "cwhprod-db-subnet-1" {
  name       = "cwhprod-db-subnetgroup"
  #subnet_ids = ["${var.private_subnets_int}"]
  subnet_ids = ["${element(aws_subnet.private_prod.*.id, 0)}", "${element(aws_subnet.private_prod.*.id, 1)}"]
  tags { Name = "cwhprod-db-subnetgroup"  }
}

# Setup Private route table for PROD
resource "aws_route_table" "private_prod_a" {
  vpc_id           = "${aws_vpc.cwhvpcprod.id}"
  tags{ "Name" = "${format("%s-prod-route-private-1a", var.name)}" "terraform" = "yes"}
}
resource "aws_route_table" "private_prod_b" {
  vpc_id           = "${aws_vpc.cwhvpcprod.id}"
  tags{ "Name" = "${format("%s-prod-route-private-1b", var.name)}" "terraform" = "yes"}
}
resource "aws_route_table" "private_prod_c" {
  vpc_id           = "${aws_vpc.cwhvpcprod.id}"
  tags{ "Name" = "${format("%s-prod-route-private-1c", var.name)}" "terraform" = "yes"}
}

# Setup Public route table for PROD
resource "aws_route_table" "public_prod" {
  vpc_id           = "${aws_vpc.cwhvpcprod.id}"
  tags{ "Name" = "${format("%s-prod-route-public", var.name)}" "terraform" = "yes"}
}

# Associate Private subnet to route table for PROD
resource "aws_route_table_association" "private_prod_a" {
  subnet_id      = "${element(aws_subnet.private_prod.*.id, 0)}"
  route_table_id = "${aws_route_table.private_prod_a.id}"
}
resource "aws_route_table_association" "private_prod_b" {
  subnet_id      = "${element(aws_subnet.private_prod.*.id, 1)}"
  route_table_id = "${aws_route_table.private_prod_b.id}"
}
resource "aws_route_table_association" "private_prod_c" {
  subnet_id      = "${element(aws_subnet.private_prod.*.id, 2)}"
  route_table_id = "${aws_route_table.private_prod_c.id}"
}
resource "aws_route_table_association" "private_prod_aa" {
  subnet_id      = "${element(aws_subnet.private_prod.*.id, 3)}"
  route_table_id = "${aws_route_table.private_prod_a.id}"
}

# Associate Public subnet to route table for PROD
resource "aws_route_table_association" "public_prod" {
  count          = "${length(var.public_subnets_prod)}"
  subnet_id      = "${element(aws_subnet.public_prod.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_prod.id}"
}

# Associate Lambda subnet to route table for PROD
resource "aws_route_table_association" "lambda_prod_a" {
  subnet_id      = "${element(aws_subnet.lambda_prod.*.id, 0)}"
  route_table_id = "${aws_route_table.private_prod_a.id}"
}
resource "aws_route_table_association" "lambda_prod_b" {
  subnet_id      = "${element(aws_subnet.lambda_prod.*.id, 1)}"
  route_table_id = "${aws_route_table.private_prod_b.id}"
}
resource "aws_route_table_association" "lambda_prod_c" {
  subnet_id      = "${element(aws_subnet.lambda_prod.*.id, 2)}"
  route_table_id = "${aws_route_table.private_prod_c.id}"
}
resource "aws_route_table_association" "lambda_prod_aa" {
  subnet_id      = "${element(aws_subnet.lambda_prod.*.id, 3)}"
  route_table_id = "${aws_route_table.private_prod_a.id}"
}

# Associate ELB subnet to route table for PROD
# resource "aws_route_table_association" "elb_prod" {
#   count          = "${length(var.elb_subnets_prod)}"
#   subnet_id      = "${element(aws_subnet.elb_prod.*.id, count.index)}"
#   route_table_id = "${aws_route_table.public_prod.id}"
# }

# Setup route for public internet gateway for PROD
 resource "aws_route" "public_prod_internet_gateway" {
   route_table_id         = "${aws_route_table.public_prod.id}"
   destination_cidr_block = "0.0.0.0/0"
   gateway_id             = "${aws_internet_gateway.cwhvpcprod.id}"
 }

# Setup VPC endpoint to access to S3 (logrotate)
resource "aws_vpc_endpoint" "endpoint-s3" {
  vpc_id       = "${aws_vpc.cwhvpcprod.id}"
  service_name = "${var.logrotate-s3-service}"
  route_table_ids = ["${aws_route_table.private_prod_a.id}", "${aws_route_table.private_prod_b.id}", "${aws_route_table.private_prod_c.id}"]
  policy = <<POLICY
  {
      "Statement": [
          {
              "Action": "*",
              "Effect": "Allow",
              "Resource": "*",
              "Principal": "*"
          }
      ],
    "Version": "2008-10-17"
  }
POLICY
}

/*# Setup route to Bridgestone (Private PROD A)
resource "aws_route" "private_prod_a_bridgestone" {
  route_table_id         = "${aws_route_table.private_prod_a.id}"
  destination_cidr_block = "199.48.30.0/24"
  instance_id            = "${aws_instance.prod-vpnipsec.id}"
}

# Setup route to Bridgestone (Private PROD C)
resource "aws_route" "private_prod_c_bridgestone" {
  route_table_id         = "${aws_route_table.private_prod_b.id}"
  destination_cidr_block = "199.48.30.0/24"
  instance_id            = "${aws_instance.prod-vpnipsec.id}"
}

# Setup route to Bridgestone (Private PROD D)
resource "aws_route" "private_prod_d_bridgestone" {
  route_table_id         = "${aws_route_table.private_prod_c.id}"
  destination_cidr_block = "199.48.30.0/24"
  instance_id            = "${aws_instance.prod-vpnipsec.id}"
}

# Setup route to Bridgestone (Public Prod)
resource "aws_route" "public_prod_bridgestone" {
  route_table_id         = "${aws_route_table.public_prod.id}"
  destination_cidr_block = "199.48.30.0/24"
  instance_id            = "${aws_instance.prod-vpnipsec.id}"
}*/
