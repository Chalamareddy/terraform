# Create Simple AD (cwh.local)
 resource "aws_directory_service_directory" "cwhsimplead" {
   name     = "cwh.local"
   password = "${var.adpass}"
   size     = "Small"

   vpc_settings {
      vpc_id     = "${aws_vpc.cwhvpcprod.id}"
      subnet_ids      = ["${element(aws_subnet.public_prod.*.id, 0)}", "${element(aws_subnet.public_prod.*.id, 1)}"]
  }
}

# Create DHCP Options
resource "aws_vpc_dhcp_options" "cwhdhcp" {
  domain_name          = "${var.addomain}"
  domain_name_servers   = ["${aws_directory_service_directory.cwhsimplead.dns_ip_addresses}"]
  tags { "Name" = "cwh-dev_simple-ad" "terraform" = "yes"}
}

# Associate DHCP Options with VPC PROD
resource "aws_vpc_dhcp_options_association" "cwhproddhcp" {
  vpc_id          = "${aws_vpc.cwhvpcprod.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.cwhdhcp.id}"
}
