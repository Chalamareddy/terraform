# Setup NAT gateway
resource "aws_nat_gateway" "prod_a_natgw" {
  allocation_id = "${var.natgw_prod_a_eip}"
  subnet_id     = "${element(aws_subnet.public_prod.*.id, 0)}"
}
resource "aws_nat_gateway" "prod_b_natgw" {
  allocation_id = "${var.natgw_prod_b_eip}"
  subnet_id     = "${element(aws_subnet.public_prod.*.id, 1)}"
}
resource "aws_nat_gateway" "prod_c_natgw" {
  allocation_id = "${var.natgw_prod_c_eip}"
  subnet_id     = "${element(aws_subnet.public_prod.*.id, 2)}"
}

# Setup NAT gateway route for private subnet
resource "aws_route" "private_prod_a_internet_gateway" {
  route_table_id         = "${aws_route_table.private_prod_a.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.prod_a_natgw.id}"
}
resource "aws_route" "private_prod_b_internet_gateway" {
 route_table_id         = "${aws_route_table.private_prod_b.id}"
 destination_cidr_block = "0.0.0.0/0"
 nat_gateway_id = "${aws_nat_gateway.prod_b_natgw.id}"
}
resource "aws_route" "private_prod_c_internet_gateway" {
 route_table_id         = "${aws_route_table.private_prod_c.id}"
 destination_cidr_block = "0.0.0.0/0"
 nat_gateway_id = "${aws_nat_gateway.prod_c_natgw.id}"
}
